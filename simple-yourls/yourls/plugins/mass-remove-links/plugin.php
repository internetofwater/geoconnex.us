<?php
/*
Plugin Name: Mass Remove Links
Plugin URI: https://github.com/YOURLS/mass-remove-links/
Description: Remove several (or all) links.
Version: 1.1
Author: Ozh
Author URI: http://ozh.org/
*/

yourls_add_action( 'plugins_loaded', 'ozh_yourls_linkmr_add_page' );
function ozh_yourls_linkmr_add_page() {
    yourls_register_plugin_page( 'ozh_lmr', 'Link Mass Remove', 'ozh_yourls_linkmr_do_page' );
}

// Display admin page
function ozh_yourls_linkmr_do_page() {
    echo <<<HTML
        <h2>Link Mass Remove</h2>
HTML;
    if( isset( $_POST['action'] ) && $_POST['action'] == 'link_mass_remove' ) {
        ozh_yourls_linkmr_process();
    } else {
        ozh_yourls_linkmr_form();
    }
}

// Display form
function ozh_yourls_linkmr_form() {
    $nonce = yourls_create_nonce('link_mass_remove');
    echo <<<HTML
        <p>Remove the following links:</p>
        <form method="post">

        <input type="hidden" name="action" value="link_mass_remove" />
        <input type="hidden" name="nonce" value="$nonce" />

        <p><label for="radio_date">
        <input type="radio" name="what" id="radio_date" value="date"/>All links created on date
        </label>
        <input type="text" name="date" /> (YYYY/MM/DD)
        </p>

        <p><label for="radio_daterange">
        <input type="radio" name="what" id="radio_daterange" value="daterange"/>All links created between
        </label>
        <input type="text" name="date1" /> and <input type="text" name="date2" /> (YYYY/MM/DD)
        </p>

        <p><label for="radio_ip">
        <input type="radio" name="what" id="radio_ip" value="ip"/>All links created by IP
        </label>
        <input type="text" name="ip" />
        </p>

        <p><label for="radio_url">
        <input type="radio" name="what" id="radio_url" value="url"/>All links pointing to a long URL containing
        </label>
        <input type="text" name="url" /> (case sensitive)
        </p>

        <p><label for="radio_all">
        <input type="radio" name="what" id="radio_all" value="all"/>All links. All.
        </label>
        </p>

        <p><label for="check_test"><input type="checkbox" id="check_test" checked="checked" name="test" value="test" /> <strong>Display results, do not delete. This is a test. </strong></label></p>

        <p><input type="submit" value="Delete" /> (no undo!)</p>
        </form>

        <script>
        function select_radio(el){
                $(el).parent().find(':radio').click();
        }
        $('input:text')
            .click(function(){select_radio($(this))})
            .focus(function(){select_radio($(this))})
            .change(function(){select_radio($(this))});
        </script>
HTML;
}

function ozh_yourls_linkmr_process() {
    // Check nonce
    yourls_verify_nonce( 'link_mass_remove' );

    $where = '';
    $binds = array();

    switch( $_POST['what'] ) {
        case 'all':
            $where = '1=1';
            break;

        case 'date':
            $where = "`timestamp` BETWEEN :date1 and :date2";
            $binds['date1'] = $_POST['date'] . ' 00:00:00';
            $binds['date2'] = $_POST['date'] . ' 23:59:59';
            break;

        case 'daterange':
            $where = "`timestamp` BETWEEN :date1 and :date2";
            $binds['date1'] = $_POST['date1'] . ' 00:00:00';
            $binds['date2'] = $_POST['date2'] . ' 00:00:00';
            break;

        case 'ip':
            $where = "`ip` = :ip";
            $binds['ip'] = $_POST['ip'];
            break;

        case 'url':
            $where = "`url` LIKE (:url)";
            $binds['url'] = str_replace( '*', '%', '*' . $_POST['url'] . '*' );
            break;

        default:
            echo 'Not implemented';
            return;
    }

    global $ydb;

    $action = ( isset( $_POST['test'] ) && $_POST['test'] == 'test' ) ? 'SELECT' : 'DELETE' ;
    $select = ( $action == 'SELECT' ) ? '`keyword`,`url`' : '';

    $table = YOURLS_DB_TABLE_URL;
    $sql = "$action $select FROM `$table` WHERE $where";

    if( $action == 'SELECT' ) {
        $query = $ydb->fetchObjects($sql, $binds);
        if( !$query ) {
            echo 'No link found.';
            return;
        } else {
            echo '<p>'.count( $query ).' found:</p>';
            echo '<ul>';
            foreach( $query as $link ) {
                $short = $link->keyword;
                $url   = $link->url;
                echo "<li>$short: <a href='$url'>$url</a></li>\n";
            }
            echo '</ul>';
            unset( $_POST['test'] );
            echo '<form method="post">';
            foreach( $_POST as $k=>$v ) {
                if( $v ) {
                    echo "<input type='hidden' name='$k' value='$v' />";
                }
            }
            echo '<input type="submit" value="OK. Delete" /></form>';
        }
    } else {
        $query = $ydb->fetchAffected($sql, $binds);
        echo $query . ' ' . yourls_n('link', 'links', $query) . ' deleted.';
    }
}

