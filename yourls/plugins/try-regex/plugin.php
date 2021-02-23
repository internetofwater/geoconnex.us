<?php
/*
Plugin Name: Try Regex Matching in Short URLs
Plugin URI: http://yourls.org/
Description: Queries for regex-like Short URLs
Version: 1.0
Author: Ben Webb
Author URI: http://github.com/Webb-Ben
*/

yourls_add_action( 'redirect_keyword_not_found', 'try_regex' );
function try_regex( $args ) {

    global $ydb;
    $table = YOURLS_DB_TABLE_URL;
    $keyword = $args[0];
    $sanitized_val = yourls_sanitize_keyword( $keyword );
    $pattern = '^%$';
    $sql   = "SELECT * FROM `$table` WHERE `keyword` LIKE '$pattern' AND '$sanitized_val' REGEXP `keyword`";

    $sql_result = $ydb->fetchObject( $sql );
    echo "<br> Retrieved Row: ";
    var_dump($sql_result);
    echo "<br><br> Regex Long URL: ", $sql_result->{"url"};
    echo "<br><br> Regex Short URL: ", $sql_result->{"keyword"};
    echo "<br> Query String: ", $sanitized_val;
    $basename = basename($sanitized_val);
    echo "<br> Query Basename: ", $basename;
    $redirect_url = str_replace("$1", $basename, $sql_result->{"url"});
    echo "<br> Redirect URL: ", $redirect_url;

    die();
}



