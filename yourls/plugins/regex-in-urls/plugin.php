<?php
/*
Plugin Name: Regex Character Matching in Short URLs
Plugin URI: http://yourls.org/
Description: Regex characters and metacharacters in Short URLs
Version: 1.0
Author: Ben Webb
Author URI: http://github.com/Webb-Ben
*/

if( !defined( 'YOURLS_ABSPATH' ) ) die();

yourls_add_filter( 'get_shorturl_charset', 'regex_in_charset' );
function regex_in_charset( $in ) {
        return $in.'_[]{}()^*\/-+?|$.';
}
