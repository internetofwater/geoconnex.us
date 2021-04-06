# Bulk Import and Shorten - a YOURLS plugin

Plugin for [YOURLS](http://yourls.org) 1.7.x.

* Plugin URI:       [github.com/vaughany/yourls-bulk-import-and-shorten](https://github.com/vaughany/yourls-bulk-import-and-shorten)
* Description:      A YOURLS plugin allowing importing of URLs in bulk to be shortened or (optionally) with a custom short URL.
* Version:          0.4
* Release date:     2020-07-31
* Author:           Paul Vaughan
* Author URI:       [github.com/vaughany](http://github.com/vaughany/)


## Description

I looked at an import/export plugin for YOURLS but it only imported what it exported (for backup and restore purposes, I assume).  I needed a way of getting long URLs into YOURLS in bulk, and not one at a time or via the Bookmarklets (as the links don't exist just yet).  This plugin solves that problem.  If you can create a CSV file, you can use this plugin.

Note: CSV (comma-separated value) files are plain text files with columns separated by commas and fields deliniated by double quotes, and rows deliniated by carriage returns.  MS Excel, OpenOffice/LibreOffice and Google Spreadsheets can all export data in CSV format.


## Installation

1. In `/user/plugins`, create a new folder named `bulk-import-and-shorten`.
2. Drop these files in that directory.
3. Go to the Manage Plugins page (e.g. `http://sho.rt/admin/plugins.php`) and activate the plugin.
4. Under the Manage Plugins link should be a new link called `Bulk Import and Shorten`.
5. Have fun!


## Configuration

This plugin has no user-configurable options.  If you know what you're doing you can add and amend this plugin, but some changes will be easier than others. If you make substantial improvements, [let me know](https://github.com/vaughany/yourls-bulk-import-and-shorten/issues).


## Use

This plugin expects you to upload a CSV file with at least one column and optional second and third columns.  The first column should contain the long URL of the 'target', e.g. http://bbc.co.uk. The optional second column can contain a keyword you would like to associate with this URL, if you don't want YOURLS to generate one for you.  The third column contains an optional title. If one is not supplied, YOURLS generates one for you.

Note: In this repository is a file called `test.csv`, which you can use as an example.


### No keywords

If you don't specify a keyword in the CSV file, YOURLS will make a short URL for you.  As default, this will be an integer (starting at '1' when YOURLS was first installed) and will increase by 1 with each additional URL, but you have more options:

* If you have the [Random Keywords plugin](https://github.com/yourls/random-keywords) installed and activated, that will be used to generate a random alpha-numeric short URL.
* If you have changed the `YOURLS_URL_CONVERT` setting (in `user/config.php`) from the default of '36' to '62' you will get an alpha-numeric short URL using both lowercase and UPPERCASE letters.
* If you have the [Force Lowercase plugin](https://github.com/yourls/force-lowercase) installed and activated, the short URL will be forced into lowercase (producing the same result as if `YOURLS_URL_CONVERT` was set to the default of '36' still).


### With keywords

If you supply keywords in the second column of the CSV file, then when imported, YOURLS will handle them according to the configuration settings and activated plugins. YOURLS always strips out (and never uses) any non-alpha-numeric characters (with the exception being hyphens, but read on):

* If you are using the '36' setting for `YOURLS_URL_CONVERT` (in `user/config.php`) then any UPPERCASE LETTERS in your supplied keyword will be *removed* from your keyword.  Not lowercased: removed. `ABCdef123` will become `def123`. `BBC` will become an empty string and will be treated as if you hadn't supplied a keyword.  If you use the '62' setting (which includes both cases), this won't happen, but remember that you shouldn't change this setting after installation.  Example CSV file:

> `http://bbc.co.uk/,bbcnews`   -->     Will import as-is.

> `http://bbc.co.uk/,BBC`       -->     UPPERCASE letters are stripped out (with '36' setting) and will import as if it had no keyword supplied. With the '62' setting, will import as-is.

> `http://bbc.co.uk/,BBCnews`   -->     Will become `news` (with '36' setting) or will import as-is (with '62' setting).

* You can get around the above by installing and activating the [Force Lowercase plugin](https://github.com/yourls/force-lowercase):

> `http://bbc.co.uk/,bbcnews`   -->     Will import as-is.

> `http://bbc.co.uk/,BBC`       -->     Will become 'bbc'.  (If not using the plugin, will import as-is.)

> `http://bbc.co.uk/,BBCnews`   -->     Will become 'bbcnews' and therefore a duplicate, so will not be imported. (If not using the plugin, will import as-is.)

* If you have `YOURLS_UNIQUE_URLS` set to 'true' (in `user/config.php`) which is the default, then multiple short URLs pointing to the same long URL (as in the previous examples, all using the same long URL) will not be allowed, and during import will be rejected.  Change the setting to 'false' to allow this:

> `http://bbc.co.uk/,bbc`       -->     Will import fine.

> `http://bbc.co.uk/,news`      -->     Will be rejected if `YOURLS_UNIQUE_URLS` is 'true', or allowed if 'false'.

* If you want to use hyphens / dashes in your short URLs, you need to activate the 'Allow hyphens in short URLs' plugin which comes with YOURLS.

> `http://bbc.co.uk/,bbc-news`  -->     Without the plugin activated, will become 'bbcnews'. With the plugin activated, will import as-is.

I have talked through some common plugins and the outcomes of various situations, but please check carefully the short URLs of bulk-imported long URLs to ensure everything is as you expect.  Due to the way plugins can hook into YOURLS I cannot know what plugins are installed and how they may affect how a short URL is created.


### Titles

Normally, YOURLS will try to get a title for you by downloading the web page from the supplied URL and checking the raw HTML for a title.  This is possibly the reason for slow bulk importing, when extremely large CSV files are uploaded.  This plugin prevents YOURLS from doing it's job and instead creates a title from the supplied URL, or uses the one in the third column of the CSV, if present and non-empty.


## Troubleshooting

One user experienced timeout issues processing a CSV file containing ~60,000 rows. I've not investigated this issue thoroughly, but the 0.2 version contains a line that creates a title from the supplied URL instead of letting YOURLS CURLing the URL and extracting a title from the returned HTML.  I believe this to be faster, but I have only done a little testing.

Some ideas, if processing a large CSV file:

* Increase the `max_execution_time` setting in your `php.ini` file from it's default of 30 seconds.
* Increase the `max_input_time` setting in your `php.ini` file from it's default of 60 seconds.

**Note:** Setting either of these to 300 / 600 / 900 seconds (5 / 10 / 15 minutes) is not unreasonable.

I've not investigated memory issues at this point, however I'd like to hear back if you have any experience of these (or any issues, for that matter).


## License

Uses YOURLS' license, aka *"Do whatever the hell you want with it"*.  I borrowed some code from others (including [GautamGupta](https://github.com/gautamgupta/yourls-Import-Export) who in turn borrowed from [John Godley](http://urbangiraffe.com/plugins/redirection/)) whose code had no licence so I can't claim this whole plugin as my own work, but the lion's share of it is.


## Bugs and Features

I'm always keen to add new features, improve performance and squash bugs, so if you do any of these things, let me know. [Fork the project](https://github.com/vaughany/yourls-bulk-import-and-shorten/), make your changes and send me a pull request.  If you find a bug but aren't a coder yourself, [open an issue](https://github.com/vaughany/yourls-bulk-import-and-shorten/issues) and give me as much detail as possible about the problem:

* What you did
* What you expected to happen
* What actually happened
* Steps to reproduce


## To-Do

* Make theforcing of titles to either generated from the URL or specified in the CSV file optional, so that YOURLS can try to pull one from the URL's website's HTML (which is probably the preferred option, but slow when doing huge imports).


## History

* **2020-07-31, v0.4:**     No meaningful code changes, but added a small Bash (Linux) script to make a large single-column CSV file for testing. You should be able to run it within Bash with `./create-large-csv.sh`. You might have to `chmod +x create-large-csv.sh` first.
* **2020-07-25, v0.3:**     Going through the issues on GitHub and saw #3 which looked like an easy addition, so now if a third, optional field is specified in the URL, that is used as a title.
* **2020-07-25, v0.2:**     From a bug report via email about it running slowly processing thousands of rows, I've attempted a 'fix' by creating a title from the URL and passing that to the YOURLS function that would otherwise attempt to fetch one from the URL's HTML.
* **2014-07-17, v0.1:**     Still a work in progress.

## Finally...

I hope you find this plugin useful.
