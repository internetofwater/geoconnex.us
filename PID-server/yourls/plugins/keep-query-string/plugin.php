<?php
/*
Plugin Name: Keep Query String
Description: Adds short URL query string, if any, to the long URL
Version: 1.0
Author: Ozh, Rich Christiansen
*/

yourls_add_filter('redirect_location', 'ozh_kqs');

function ozh_kqs($url){
	if (yourls_is_GO()) {
		//$url = yourls_add_query_arg($_GET, $url);
    $url = ozh_kqs_yourls_add_query_arg($_GET, $url);
  }
  
	return $url;
}


/*
The following function was adapted from `yourls_add_query_arg()` with the following modifications:
	1. If the longurl contains slashes (and probably other special characters) in its query string, they will be double encoded. Commenting out the call to `yourls_urlencode_deep()` seems to prevent this double-encoding.
	2. Certain internet services (e.g. Facebook) append query string parameters automatically. These parameters are generally ignored by websites/webapps when unneeded, but sometimes their presence actually causes the site to generate an error (e.g. 404 Not Found). This function includes a `$blacklist` of parameters that will *not* be passed along to the longurl. Feel free to edit this blacklist.
*/
/**
 * Add a query var to a URL and return URL. Completely stolen from WP.
 *
 * Works with one of these parameter patterns:
 *     array( 'var' => 'value' )
 *     array( 'var' => 'value' ), $url
 *     'var', 'value'
 *     'var', 'value', $url
 * If $url omitted, uses $_SERVER['REQUEST_URI']
 *
 * The result of this function call is a URL : it should be escaped before being printed as HTML
 *
 * @since 1.5
 * @param string|array $param1 Either newkey or an associative_array.
 * @param string       $param2 Either newvalue or oldquery or URI.
 * @param string       $param3 Optional. Old query or URI.
 * @return string New URL query string.
 */
function ozh_kqs_yourls_add_query_arg() {
	$ret = '';
	if ( is_array( func_get_arg(0) ) ) {
		if ( @func_num_args() < 2 || false === @func_get_arg( 1 ) )
			$uri = $_SERVER['REQUEST_URI'];
		else
			$uri = @func_get_arg( 1 );
	} else {
		if ( @func_num_args() < 3 || false === @func_get_arg( 2 ) )
			$uri = $_SERVER['REQUEST_URI'];
		else
			$uri = @func_get_arg( 2 );
	}

	$uri = str_replace( '&amp;', '&', $uri );


	if ( $frag = strstr( $uri, '#' ) )
		$uri = substr( $uri, 0, -strlen( $frag ) );
	else
		$frag = '';

	if ( preg_match( '|^https?://|i', $uri, $matches ) ) {
		$protocol = $matches[0];
		$uri = substr( $uri, strlen( $protocol ) );
	} else {
		$protocol = '';
	}

	if ( strpos( $uri, '?' ) !== false ) {
		$parts = explode( '?', $uri, 2 );
		if ( 1 == count( $parts ) ) {
			$base = '?';
			$query = $parts[0];
		} else {
			$base = $parts[0] . '?';
			$query = $parts[1];
		}
	} elseif ( !empty( $protocol ) || strpos( $uri, '=' ) === false ) {
		$base = $uri . '?';
		$query = '';
	} else {
		$base = '';
		$query = $uri;
	}

	parse_str( $query, $qs );
	//$qs = yourls_urlencode_deep( $qs ); // this re-URL-encodes things that were already in the query string
	if ( is_array( func_get_arg( 0 ) ) ) {
		$kayvees = func_get_arg( 0 );
		$qs = array_merge( $qs, $kayvees );
	} else {
		$qs[func_get_arg( 0 )] = func_get_arg( 1 );
	}
	
	//Blacklist of query string parameters (case sensitive) that will *not* be passed along. Note that we're using the parameter name as the key to provide quick lookups (~O(1) complexity)
	$blacklist = array(
		"fbclid" => true,
	);
	
	foreach ( (array) $qs as $k => $v ) {
		// if ( $v === false ) //Modified version on the next line additionally removes blacklisted parameters.
		if ( $v === false || array_key_exists($k, $blacklist) )
			unset( $qs[$k] );
	}

	$ret = http_build_query( $qs );
	$ret = trim( $ret, '?' );
	$ret = preg_replace( '#=(&|$)#', '$1', $ret );
	$ret = $protocol . $base . $ret . $frag;
	$ret = rtrim( $ret, '?' );
	return $ret;
}
