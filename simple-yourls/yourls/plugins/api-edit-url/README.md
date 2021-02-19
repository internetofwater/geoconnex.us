yourls-api-edit-url
===================

YOURLS plugin to add two additional commands to the YOURLS API.
- update - a function to update the long URL associated with a short code
- geturl - a function to get the shortcode associated with a long URL
- change_keyword - a function to update the short code associated with a URL

The geturl function does not create a new short code if the URL does not exist, it's purely designed to verify if the URL has been set up. Currently this has not been tested on a site using duplicate URLs.

The update function lets a site update the long URL associated with a short code. There is no security checking on this, as long as the API key is valid it will update, so make sure your key is secure if you plan to use this plugin!

The change_keyword function takes three parameters. "url" is the current URL, "oldshortcode" is the current keyword you want to change, and "newshortcode" is the new keyword you'll change it to. The keyword cannot currently be used in YOURLS.

How to install this plugin
==========================
1. Create a new directory under the "user/plugins" directory
2. Save the "plugin.php" file into the directory you created in step 1
3. Activate the plugin using your YOURLS admin panel 
