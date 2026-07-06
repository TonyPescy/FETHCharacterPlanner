import requests
from bs4 import BeautifulSoup
import pandas as pd

URL = ""

headers = {
    "User-Agent": "Mozilla/5.0"
}

def scrape_character_max_stats():
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
            for i in range(len(cols)):
                if cols[i] == "":
                    cols[i] = "0"

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
    data = scrape_character_max_stats()

    df = pd.DataFrame(data)

    df.to_csv("fe3h_character_max_stats.csv", index=False)
    df.to_json("fe3h_character_max_stats.json", orient="records", indent=2)

    print(f"Saved {len(df)} classes!")


if __name__ == "__main__":
    main()