import subprocess
import tempfile

import requests
from bs4 import BeautifulSoup


def open_image_from_url(url):
    try:
        # Fetch the image from the URL
        response = requests.get(url)
        response.raise_for_status()

        # Save the image to a temporary file
        with tempfile.NamedTemporaryFile(delete=False, suffix=".png") as temp_file:
            temp_file.write(response.content)
            temp_file_path = temp_file.name

        # Open the image with Preview (macOS default image viewer)
        subprocess.call(["open", "-a", "Preview", temp_file_path])

    except Exception as e:
        print(f"Error: {e}")


def get_description(soup: BeautifulSoup):
    summary_points = soup.find("ul", class_="summary-points")

    if summary_points:
        description_items = [
            item.get_text(strip=True) for item in summary_points.find_all("li")
        ]
        print("Description:")
        for item in description_items:
            print(f" - {item}")
    else:
        print("Description not found on the webpage.")

    description = soup.find("div", class_="description").get_text()
    print(description)


def get_cheese_of_the_day():
    main_url = "https://www.cheese.com/"

    response = requests.get(main_url)

    if response.status_code != 200:
        print("Failed to fetch the website. Please try again later.")
        return

    soup = BeautifulSoup(response.text, "html.parser")

    cheese_of_the_day = soup.find("div", id="cheese-of-day")

    cheese_link = cheese_of_the_day.find("a", href=True)

    cheese_name = cheese_link["href"].replace("/", "")
    full_url = f"{main_url}{cheese_name}"

    print("Cheese of the Day:")
    print(f"    Name: {cheese_name}")
    print(f"    {full_url}")
    print()

    cheese_response = requests.get(full_url)
    cheese_soup = BeautifulSoup(cheese_response.text, "html.parser")

    get_description(cheese_soup)
    # print(f"Description: {cheese_description}")

    # Find all img tags with src containing "cheese-suggestion"
    img_tag = cheese_soup.find(
        "img",
        src=lambda value: value and "cheese-suggestion" in value,
    )

    cheese_suggestion_url = img_tag["src"]
    cheese_img_path = (
        cheese_suggestion_url
        if cheese_suggestion_url.startswith("http")
        else cheese_suggestion_url.lstrip("/")
    )
    full_img = f"{main_url}{cheese_img_path}"
    open_image_from_url(full_img)


if __name__ == "__main__":
    get_cheese_of_the_day()
