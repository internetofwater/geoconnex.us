<?php
/*
Plugin Name: RESET URLS
Plugin URI: http://yourls.org/
Description: OMG
Version: 1.0
Author: Ozh
Author URI: http://ozh.org/
*/

// Register our plugin admin page
yourls_add_action( 'plugins_loaded', 'ozh_yourls_resetall_add_page' );
function ozh_yourls_resetall_add_page() {
	yourls_register_plugin_page( 'reset', 'RESET!!', 'ozh_yourls_resetall_do_page' );
	// parameters: page slug, page title, and function that will display the page itself
}

// Display admin page
function ozh_yourls_resetall_do_page() {

	// Check if a form was submitted
	if( isset( $_POST['reset'] ) && $_POST['reset'] == 'yes' ) {
		ozh_yourls_resetall_urls();
		
	} else {

		echo <<<HTML
			<h2>RESET DB</h2>
			<p>DELETE ALL URLS??</p>
			<form method="post">
			<input type="hidden" name="reset" value="yes" />
			<p><input type="submit" value="YES" /></p>
			</form>
HTML;
	}
}

// Update option in database
function ozh_yourls_resetall_urls() {
	$sql = "TRUNCATE TABLE ". YOURLS_DB_TABLE_URL.";";
	
	global $ydb;
	$ydb->query( $sql );
	
	echo "<p class='error'>ALL GONE OMG!!</p>";

}
