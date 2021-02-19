# YOURLS API plugin: action=lookup-url-substr

This YOURLS plugin adds new command to the YOURLS API: `action=lookup-url-substr` — searches all keywords in the database which resolve to long URLs containing specified substring. API call requires `substr` parameter. Literally `LIKE %substr%` SQL expression is used for entries filtering.

The plugin is useful when searching for URLs disregarding GET parameters: for example, search URL with any UTM tags combination.

## Example
Assume your database contains the following entries:
| keyword | url | _comment_ |
| - | - | - |
| kw1 | https://subdomain.example.com/?abc=def | https, subdomain and parameter 1 |
| kw2 | subdomain.example.com | subdomain only |
| kw3 | https://subdomain.example.com?utm=123 | https, subdomain and parameter 2 |
| kw4 | http://example.com?utm=123 | http and parameter 2 |
| kw5 | http://example.com?abc=def&utm=123 | http, parameters 1 and 2 |

The following API calls will respond with the corresponding `keywords` field values:
* `action=lookup-url-substr&substr=subdomain.example.com` => `["kw1","kw2","kw3"]`
* `action=lookup-url-substr&substr=example.com` => `["kw1","kw2","kw3","kw4","kw5"]`
* `action=lookup-url-substr&substr=https://subdomain.example.com` => `["kw1","kw3"]`
* `action=lookup-url-substr&substr=example.com?utm=123` => `["kw3","kw4"]`

## How to install this plugin
1. Copy plugin files to `$YOURLS_ABSPATH/user/plugins`:
    1. `cd` into directory defined via `$YOURLS_ABSPATH` configuration parameter of your YOURLS installation.
    2. `cd user/plugins`
    3. Copy files:
        1. Either clone via git: `git clone https://github.com/bryzgaloff/yourls-api-lookup-keywords-by-url-substr.git`. This will create a copy of this repository in the `$YOURLS_ABSPATH/user/plugins/yourls-api-lookup-keywords-by-url-substr` directory.
        2. Or just manually create a directory `mkdir yourls-api-lookup-keywords-by-url-substr` and copy `plugin.php` file into it.
    4. Name of the plugin directory is arbitrary: all the info is stored in the comment block of `plugin.php` file.
2. Open plugins manager of your YOURLS: `https://$YOURLS_SITE/admin/plugins.php`.
3. Activate plugin.
