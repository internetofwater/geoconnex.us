<?php

/*
Plugin Name: Allow Forward Slashes in Short URLs
Plugin URI: http://williambargent.co.uk
Description: Allow Forward Slashes in Short URLs
Version: 1.0
Author: William Bargent
Author URI: http://williambargent.co.uk
*/



if( !defined( 'YOURLS_ABSPATH' ) ) die();

yourls_add_filter( 'get_shorturl_charset', 'slash_in_charset' );
function slash_in_charset( $in ) {
        return $in.'/';
}


//This plugin will not work with URL forwarding plugins active
