import os
from pathlib import Path
import csv
import re

def valid_email(email: str):
    # Remove leading and trailing whitespace to allow for more flexibility in
    # user submissions
    email = email.strip()
    pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    return re.match(pattern, email)

def assert_valid_csv(csv_path: Path):
    """
    Assert that a csv file is valid according to the Geoconnex specification
    """
    with open(csv_path, 'r') as f:
        reader = csv.reader(f, delimiter=',')
        requiredHeaders = {"id", "target", "creator", "description"}
        headers = set(next(reader))
        assert requiredHeaders.issubset(headers), f"{csv_path.name} headers '{headers}' does not contain {requiredHeaders}"

        for row in reader:
            assert len(row) >= 4
            CREATOR_COLUMN = 2
            assert valid_email(row[CREATOR_COLUMN]), f"{csv_path.name} creator '{row[CREATOR_COLUMN]}' is not a valid email"


def list_dir(dir: Path):
    """
   Recursively list all files in a directory
    """
    if dir.is_file():
        if dir.suffix == ".csv":
            assert_valid_csv(dir)
            print(f"{dir} is valid")
        return

    for file in dir.iterdir():
        list_dir(file)

repo_root = Path(__file__).resolve().parent.parent
os.chdir(repo_root)
list_dir(repo_root)