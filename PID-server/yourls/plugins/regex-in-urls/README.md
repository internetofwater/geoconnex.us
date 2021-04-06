# Regex in Yourls

Retrieves the long URL where the short URL is a regex expression of the requested keyword.
Requires [YOURLS](https://yourls.org) `1.7.9` and above.

## Usage

Enable the plugin in the admin interface.
Plugin must be enabled to include regex characters in the short URL charset. 

This function expects all regex-like short URLs to follow the pattern "^%$". 
The pattern can be changed, or not used at all.

Expects the long URL to include `$1` at the location to forward the basename of the keyword.


## Installation

1. In `/user/plugins`, create a new folder named `regex-in-urls`.
2. Add these files to that directory.
3. Go to the Manage Plugins page in yourls admin interface and activate the plugin.
4. Add any regex like expression as a short URL and let the magic happen!

## License

This package is licensed under the [MIT License](LICENSE).
