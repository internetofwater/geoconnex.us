<?php
/*
Plugin Name: Meta Redirect
Plugin URI: https://yourls.org/
Description: use to redirect with meta tag by add _ (underscore) before keyword
Version: 1.0
Author: Pakkapon Phongthawee
Author URI: https://kuy.me/
*/

// you need to change it
define( 'PAKKAPON_MRDR_URL_PREFIX', '_' ); // change prefix as you want
define( 'PAKKAPON_MRDR_DELAY', '1' ); // delay to redirect
yourls_add_action( 'loader_failed', 'pakkapon_mrdr' );
function pakkapon_mrdr( $args ) {
	if( preg_match( '!^'. PAKKAPON_MRDR_URL_PREFIX .'(.*)!', $args[0], $matches ) ) {
		$keyword = yourls_sanitize_keyword( $matches[1] );
		require_once( dirname( __FILE__ ) . '/../../../includes/load-yourls.php' );
		$url = yourls_get_keyword_longurl( $keyword );
		echo "<meta http-equiv=\"refresh\" content=\"".PAKKAPON_MRDR_DELAY."; url=".$url."\" /> You will redirect to <a href='".$url."'>".$url."</a>"; 		// redirect with text to dispaly waint wait
		exit;
	}
	// If it's not _ , do nothing and return to normal operations
}
