import json
import requests
import pandas as pd
from bs4 import BeautifulSoup

URL = "https://serenesforest.net/three-houses/characters/recruitment/"

headers = {
    "User-Agent": "Mozilla/5.0"
}


def scrape_house_members():
    res = requests.get(URL, headers=headers)
    res.raise_for_status()

    soup = BeautifulSoup(res.text, "html.parser")

    house_data = {}
    csv_rows = []

    # Every house starts with an <h4>
    for heading in soup.find_all("h4"):
        house = heading.get_text(strip=True)

        # Find the first table after this heading
        table = heading.find_next("table")
        if table is None:
            continue

        members = []

        rows = table.find_all("tr")[1:]  # Skip header

        for row in rows:
            cols = row.find_all("td")
            if not cols:
                continue

            # First column is the character name
            name = cols[0].get_text(strip=True)

            if name:
                members.append(name)
                csv_rows.append({
                    "house": house,
                    "name": name
                })

        if members:
            house_data[house] = members

    return house_data, csv_rows


def main():
    house_data, csv_rows = scrape_house_members()

    # Save JSON
    with open("fe3h_houses.json", "w", encoding="utf-8") as f:
        json.dump(house_data, f, indent=2, ensure_ascii=False)

    # Save CSV
    df = pd.DataFrame(csv_rows)
    df.to_csv("fe3h_houses.csv", index=False)

    print(f"Saved {len(df)} characters across {len(house_data)} houses.")


if __name__ == "__main__":
    main()