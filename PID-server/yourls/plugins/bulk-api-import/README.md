# Bulk API import

Bulk import urls via yourls api.
Able to quickly shorten individual urls and csv files of urls.
Require [YOURLS](https://yourls.org) `1.7.9` and above.

## Usage

Enable the plugin in the admin interface.
Works with yourls_api.py, which is an extension of [pyourls3](https://pypi.org/project/pyourls3/).

## Installation

1. In `/user/plugins`, create a new folder named `bulk_api_import`.
2. Add these files to that directory.
3. Go to the Manage Plugins page in yourls admin interface and activate the plugin.
4. Add any regex like expression as a short URL and let the magic happen!

## License

This package is licensed under the [MIT License](LICENSE).
