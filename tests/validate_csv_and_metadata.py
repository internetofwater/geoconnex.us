import json
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

def assert_valid_metadata_json(json_path: Path):
    """
    assert that a metadata json file is valid according to the Geoconnex metadata schema
    """

    with open(json_path, 'r') as f:
        try:
            metadata: dict = json.load(f)
        except json.JSONDecodeError as e:
            raise ValueError(f"{json_path} is not a valid json file") from e
        assert isinstance(metadata, dict), f"{json_path} is not a json file"
        # no reason for most sources to set this, so we set it to false by default
        for uncommon_key in {"requires_javascript_to_crawl", "skip_crawling"}:
            if uncommon_key not in metadata:
                metadata[uncommon_key] = False

        required_keys: set[str] = {
            "max_request_concurrency",
            "add_associated_mainstems",
            "creator_email",
            "dataset_description",
            "dataset_has_html_landing_pages",
            "skip_crawling",
            "requires_javascript_to_crawl",
        }

        for key in required_keys:
            assert key in metadata, f"{json_path} is missing required key '{key}'"

            match key:
                case "max_request_concurrency":
                    assert isinstance(metadata[key], int | None), f"{json_path.name} '{key}' must be an integer or null"
                case "creator_email":
                    assert isinstance(metadata[key], str), f"{json_path.name} '{key}' must be a string"
                    assert valid_email(metadata[key]), f"{json_path.name} '{key}' must be a valid email"
                case "dataset_description":
                    assert isinstance(metadata[key], str), f"{json_path.name} '{key}' must be a string"
                case (
                    "dataset_has_html_landing_pages"
                    | "add_associated_mainstems"
                ):
                    assert isinstance(metadata[key], bool), f"{json_path.name} '{key}' must be a boolean"
                case "skip_crawling" | "requires_javascript_to_crawl":
                    assert isinstance(metadata[key], bool), f"{json_path.name} '{key}' must be a boolean"
                case _:
                    raise ValueError(f"Unknown key '{key}' in {json_path}")
        extra_keys = set(metadata.keys()) - required_keys
        assert not extra_keys, f"{json_path} contains extra keys: {extra_keys}"
        missing_keys = required_keys - set(metadata.keys())
        assert not missing_keys, f"{json_path} is missing keys: {missing_keys}"



def list_dir(dir: Path):
    """
   Recursively list all files in a directory
    """
    if dir.is_file():
        if dir.suffix == ".csv":
            assert_valid_csv(dir)
            print(f"{dir} is valid")
        elif dir.suffix == ".json":
            if dir.name != "metadata.json":
                raise ValueError(f"Found {dir} which is a json file and should not be present in the bulk directory")
            assert_valid_metadata_json(dir)
            print(f"{dir} is valid")
        return

    for file in dir.iterdir():
        list_dir(file)

repo_root = Path(__file__).resolve().parent.parent
os.chdir(repo_root)
list_dir(repo_root / "namespaces")