import json
import os
from pathlib import Path
import csv
import re


def valid_email(email: str):
    email = email.strip()
    pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    return re.match(pattern, email)


def assert_valid_csv(csv_path: Path):
    with open(csv_path, "r") as f:
        reader = csv.reader(f, delimiter=",")
        requiredHeaders = {"id", "target", "creator", "description"}
        headers = set(next(reader))

        assert requiredHeaders.issubset(headers), (
            f"{csv_path.name} missing headers {requiredHeaders - headers}"
        )

        for row in reader:
            assert len(row) >= 4
            CREATOR_COLUMN = 2
            assert valid_email(row[CREATOR_COLUMN]), (
                f"{csv_path.name} invalid email: {row[CREATOR_COLUMN]}"
            )


def check_metadata_json(json_path: Path):
    with open(json_path, "r") as f:
        try:
            metadata = json.load(f)
        except json.JSONDecodeError:
            raise ValueError(f"Invalid JSON found at {json_path}")

        skip_crawling_case = "skip_crawling" in metadata
        bulk_case = "bulk/" in json_path.absolute().as_posix()
        crawl_features_case = "max_request_concurrency" in metadata

        match (skip_crawling_case, bulk_case, crawl_features_case):
            case (True, True, _):
                raise ValueError(
                    "Cannot have both skip_crawling and bulk in the same metadata file but found it here: "
                    + json_path.absolute().as_posix()
                )
            case (True, _, True):
                raise ValueError(
                    "Cannot have both skip_crawling and max_request_concurrency in the same metadata file but found it here: "
                    + json_path.absolute().as_posix()
                )
            case (_, True, True):
                raise ValueError(
                    "Cannot have both bulk and max_request_concurrency in the same metadata file but found it here: "
                    + json_path.absolute().as_posix()
                )
            case (True, False, False) | (False, True, False) | (False, False, True):
                pass


def list_dir(dir: Path):
    """
    Recursively validate directory structure.
    """
    if dir.is_file():
        if dir.suffix == ".csv":
            assert_valid_csv(dir)
            print(f"{dir} is valid CSV")

        elif dir.suffix == ".json":
            if dir.name != "metadata.json":
                raise ValueError(
                    f"Invalid JSON file found: {dir} (only metadata.json allowed)"
                )
            check_metadata_json(dir)
        return False  # files are not directories

    # Track what we find in this directory
    has_csv = False
    has_metadata = False
    has_subdirs = False

    for child in dir.iterdir():
        if child.is_dir():
            has_subdirs = True
            list_dir(child)
        else:
            if child.suffix == ".csv":
                has_csv = True
            if child.name == "metadata.json":
                has_metadata = True

            list_dir(child)

    if not has_subdirs:
        assert has_csv, f"Leaf directory {dir} is missing a CSV file"
        assert has_metadata, f"Leaf directory {dir} is missing metadata.json"


repo_root = Path(__file__).resolve().parent.parent
os.chdir(repo_root)
list_dir(repo_root / "namespaces")
