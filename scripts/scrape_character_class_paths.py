import requests
from bs4 import BeautifulSoup
import pandas as pd

URL = "https://serenesforest.net/three-houses/characters/other-data/"

headers = {
    "User-Agent": "Mozilla/5.0"
}

def scrape_character_class_path():
    res = requests.get(URL, headers=headers)
    soup = BeautifulSoup(res.text, "html.parser")

    data = []

    # Find all tables on page
    tables = soup.find_all("table")

    for table in tables:
        rows = table.find_all("tr")

        for row in rows[1:]:  # skip header
            cols = row.find_all("td")
            cols = [c.get_text(strip=True) for c in cols]

            # Replace empty growths with 0
            #for i in range(len(cols)):
            #    if cols[i] == "":
            #        cols[i] = "0"

            # Expect: Name + 3 stats
            if len(cols) >= 4:
                name = cols[0]

                data.append({
                    "name": name,
                    "Starting Class": cols[1],
                    "Beginner Class": cols[2],
                    "Intermediate Class": cols[3]
                })

    return data


def main():
    data = scrape_character_class_path()

    df = pd.DataFrame(data)

    df.to_csv("fe3h_character_class_path.csv", index=False)
    df.to_json("fe3h_character_class_path.json", orient="records", indent=2)

    print(f"Saved {len(df)} Characters!")


if __name__ == "__main__":
    main()