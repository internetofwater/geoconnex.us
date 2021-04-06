<?php

/*
Plugin Name:    Bulk Import and Shorten
Plugin URI:     https://github.com/vaughany/yourls-bulk-import-and-shorten
Description:    A YOURLS plugin allowing importing of URLs in bulk to be shortened or (optionally) with a custom short URL.
Version:        0.4
Release date:   2020-07-31
Author:         Paul Vaughan
Author URI:     http://github.com/vaughany/
*/

/**
 * https://github.com/YOURLS/YOURLS/wiki/Coding-Standards
 * https://github.com/YOURLS/YOURLS/wiki#for-developpers
 * https://github.com/YOURLS/YOURLS/wiki/Plugin-List#get-your-plugin-listed-here
*/

// No direct call.
if ( !defined ('YOURLS_ABSPATH') ) { die(); }

// Register admin page.
yourls_add_action( 'plugins_loaded', 'vaughany_bias_add_page' );

// Handle import.
yourls_add_action( 'load-vaughany_bias', 'vaughany_bias_handle_post' );


function vaughany_bias_add_page() {
    yourls_register_plugin_page( 'vaughany_bias', 'Bulk Import and Shorten', 'vaughany_bias_display_page' );
}

function vaughany_bias_display_page() {
    echo <<<EOT
<h2>Bulk Import and Shorten</h2>
<p>Import links as long URLs and let YOURLS shorten them for you according to your settings.</p>
<p>Upload a .csv file in the following format:</p>
<ul>
  <li>First column - required: a long URL</li>
  <li>Second column - optional: a short URL of your choosing (otherwise one will be created by YOURLS according to your settings)</li>
  <li>Third column - optional: a title of your choosing.</li>
</ul>
<p>I don't know what will happen if two short links point to the same long link - this might or might not be allowed, according to your settings.</p>

<h3>Import</h3>
EOT;

    echo '<form action="' . yourls_remove_query_arg( array( 'import', 'export', 'nonce', 'action' ) ) . '" method="post" accept-charset="utf-8" enctype="multipart/form-data">' . PHP_EOL;
    echo '  ' . yourls_nonce_field( 'vaughany_bias_import', 'nonce', false, false );
    echo '  <input type="file" name="import" value="">' . PHP_EOL;
    echo '  <input type="submit" name="import" value="Upload">' . PHP_EOL;
    echo '</form>' . PHP_EOL;
}

function vaughany_bias_handle_post() {

    if ( !empty( $_FILES['import'] ) ) {
        if ( !empty( $_POST['nonce'] ) && yourls_verify_nonce( 'vaughany_bias_import', $_POST['nonce'] ) ) {
            $count = vaughany_bias_import_urls( $_FILES['import'] );
            if ( $count > 0 ) {
                $message = $count . ' URLs imported.';
            } else {
                $message = 'No URLs imported.';
            }
        }
    }

    // Message
    if ( !empty( $message ) ) {
        yourls_add_notice($message);
    }

}

/**
 * Import the urls
 * @param type $import_file Uploaded file to be imported
 * @return int|bool Count of imported redirections or false on failure
 */
function vaughany_bias_import_urls( $file ) {

    if ( !is_uploaded_file( $file['tmp_name'] ) ) {
        yourls_add_notice('Not an uploaded file.');
    }


    global $ydb;

    ini_set( 'auto_detect_line_endings', true );
    $count  = 0;
    $fh     = fopen( $file['tmp_name'], 'r' );
    $table  = YOURLS_DB_TABLE_URL;

    // If the file handle is okay.
    if ( $fh ) {

        // Get each line in turn as an array, comma-separated.
        while ( $csv = fgetcsv( $fh, 1000, ',' ) ) {

            $url = $keyword = $title = '';

            $url = trim( $csv[0] );

            if ( isset( $csv[1] ) && !empty( $csv[1] ) ) {
                // Trim out cruft and slashes.
                $new_keyword = trim( str_replace( '/', '', $csv[1] ) );

                // If the requested keyword is not free, use nothing.
                if ( yourls_keyword_is_free( $new_keyword ) ) {
                    $keyword = $new_keyword;
                }
            }

            if ( isset( $csv[2] ) ) {
                if ( !empty ( $csv[2] ) ) {
                    $title = trim( $csv[2] );
                } else {
                    $title = vaughany_bias_create_title_from_url( $url );
                }
            } else {
                $title = vaughany_bias_create_title_from_url( $url );
            }

            // Add a new link (passing the keyword) and get the result.
            $result = yourls_add_new_link( $url, $keyword, $title );

            if ( $result['status'] == 'success' ) {
                $count++;
            }
        }

    } else {
        yourls_add_notice('File handle is bad.');
    }

    return $count;
}

/**
 * Create a title from the URL
 *
 * @param string $url   New in v0.2: Creating a title from the URL, so one is not fetched from the URL, slowing down the import.
 * @return string
 */
function vaughany_bias_create_title_from_url( string $url ) : string {
    return yourls_sanitize_title( str_replace(['http://', 'https://', '/'], '', $url) );
}
