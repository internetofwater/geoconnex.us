<?php
/*
Plugin Name: Always-303 Plugin
Plugin URI: https://github.com/tinjaw/Always-302
Description: Send a 303 (temporary) redirect instead of 301 (permanent) for sites where shortlinks may change.
Version: 1.0
Author: Tinjaw
Author URI: https://github.com/tinjaw
*/

// No direct call
if( !defined( 'YOURLS_ABSPATH' ) ) die();

yourls_add_filter( 'redirect_code', 'ksonda_303_redirection' );

function ksonda_303_redirection( $code, $location ) {
    return 303;
}