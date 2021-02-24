<?php
/*
Plugin Name: Regex Character Matching in Short URLs
Plugin URI: https://github.com/Webb-Ben/geoconnex.us/tree/master/simple-yourls/yourls/plugins/regex-in-urls
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

yourls_add_action( 'redirect_keyword_not_found', 'try_regex' );
function try_regex( $args ) {
    global $ydb;
    $table         = YOURLS_DB_TABLE_URL;
    $keyword       = $args[0];
    $sanitized_val = yourls_sanitize_keyword( $keyword );
    $pattern       = '^%$';
    $sql           = "SELECT * FROM `$table` WHERE `keyword` LIKE '$pattern' AND '$sanitized_val' REGEXP `keyword`";
    $sql_result    = $ydb->fetchObject( $sql );
    $redirect_url  = str_replace("$1", basename($sanitized_val), $sql_result->{"url"});

    yourls_redirect($redirect_url, 302);
    die();
}