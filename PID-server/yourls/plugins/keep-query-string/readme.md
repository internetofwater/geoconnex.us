# Description
By default, YOURLS ignores query string parameters on shorturls. For example:

`https://sho.rt/1?param=value` redirects to `https://example.com/longurl/here`

This plugin modifies this behavior so that the entire query string is appended onto the longurl. For example, with this plugin activated:

`https://sho.rt/1?param=value` redirects to `https://example.com/longurl/here?param=value`

## Blacklisted parameters
In order to maintain compatibility with the internet at large, this plugin *does not* pass along Facebook's `fbclid` parameter if it is present. This parameter is known to cause some websites to erroneously generate a 404 Not Found error.

If you'd like to modify this blacklist, please see the `ozh_kqs_yourls_add_query_arg()` function in `plugin.php`.

# Installation
1. In `/user/plugins`, create a new folder named `yourls-keep-query-string`.
2. Drop these files in that directory.
3. Go to the Plugins administration page (e.g. `https://sho.rt/admin/plugins.php`) and activate the plugin.
4. Have fun!

# License
Released under the [MIT License](https://opensource.org/licenses/MIT).