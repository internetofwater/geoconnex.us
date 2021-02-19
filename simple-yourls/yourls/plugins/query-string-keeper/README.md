# Query String Keeper
Query String Keeper plugin for [YOURLS](http://yourls.org) - tested on version 1.7.


Description
-----------
Query String Keeper retains the query string added to the short url and adds it to the long url. If the long URL already includes a query string, it appends it following an ampersand (&) and if not, appends it to the long url following a question mark (?).  

Examples
--------
Examples 1 & 2 use the following short & long URLs configured in YOURLS:  
Short url = `http://sho.rt/keyword`  
Long url  = `http://www.longurl.com`  

_Example 1_  
`http://sho.rt/keyword?foo=bar`  
...becomes...  
`http://www.longurl.com/?foo=bar`  

_Example 2_  
`http://sho.rt/keyword?123`  
...becomes...  
`http://www.longurl.com/?123`  

Example 3 uses the following short & long URLs configured in YOURLS:  
Short url = `http://sho.rt/keyword`  
Long url  = `http://www.longurl.com?foo=bar`  
_Example 3_  
`http://sho.rt/keyword?zoo=car`  
...becomes...  
`http://www.longurl.com/?foo=bar&zoo=car`  

Installation
------------
1. Move query-string-keeper directory to the `/user/plugins` directory of the YOURLS installation.  
2. Go to the Plugins administration page ( *eg* `http://sho.rt/admin/plugins.php` ) and activate the `Query String Keeper` plugin.  

Other/References
----------------
This plugin adapted from the Query String Forward plugin by [llonchj](https://github.com/llonchj/yourls_plugins) which doesn't handle passing a single number as in `sho.rt/foo?123`.  
The Append Query String plugin by [drockney](https://github.com/drockney/append-qs) works for those that want the query string to just be appended without the ? or & symbols.  
