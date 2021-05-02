<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wp_user' );

/** MySQL database password */
define( 'DB_PASSWORD', 'secret' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         ',C/5p2&pyo(-PlKJWehr|Ry1_q.{{Ml6|<@0R#e6;)Pvs&J.1 xl:^PwyspWLfw_');
define('SECURE_AUTH_KEY',  '(H4>Ho}|GYoU8-Q2I}G!T^Ure!IrV]UdB%7sg|US!WkPrn^<+5AB~_g3 xMx>^E@');
define('LOGGED_IN_KEY',    ')j}d:-&/bMi1-bockx67&,<?02~`fg7Qrc&Cq5Jbc=3d5X+b.]bvQ55os.B-:K+k');
define('NONCE_KEY',        '7-95vqG`|-xLiCrlv^qgN(^s86(l[WBfq}*R|}C.9=SE}u<u<(.`?N0=+JXQF5x-');
define('AUTH_SALT',        '|2v:3dkBp/&5;-J|N{/j5K/v)-Nr[;--/gvl?y&|,2#i@u9^0UNFXw[K|BM?:x6G');
define('SECURE_AUTH_SALT', '4FjIj+sXOXo2)(Yz5=iGsM!t8!?5)S30n-KF>nCGZm)r^6A&srWO02<vyk/T6l[t');
define('LOGGED_IN_SALT',   '8y8J}~u!vx**&%8uc/Zob/T8QErS(Lr. -j[nOy<cv|eD*#Yt+fHh8+pBDsK,kXw');
define('NONCE_SALT',       '_Wc:0RF+/YM&_}]#?QS.N.-+[daybw rTd=%X 8(c,^-s4<K,,eySgws`ORB[xma');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';