import requests
from bs4 import BeautifulSoup
import pandas as pd

URL = "https://serenesforest.net/three-houses/characters/growth-rates/"

headers = {
    "User-Agent": "Mozilla/5.0"
}

def scrape_character_growths():
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

            # Expect: Name + 9 stats
            if len(cols) >= 10:
                name = cols[0]

                data.append({
                    "name": name,
                    "HP": cols[1],
                    "Str": cols[2],
                    "Mag": cols[3],
                    "Dex": cols[4],
                    "Spd": cols[5],
                    "Lck": cols[6],
                    "Def": cols[7],
                    "Res": cols[8],
                    "Cha": cols[9],
                })

    return data


def main():
    data = scrape_character_growths()

    df = pd.DataFrame(data)

    df.to_csv("fe3h_growth_rates.csv", index=False)
    df.to_json("fe3h_growth_rates.json", orient="records", indent=2)

    print(f"Saved {len(df)} characters")


if __name__ == "__main__":
    main()