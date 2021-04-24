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
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'root' );

/** MySQL database password */
define( 'DB_PASSWORD', '' );

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
define('AUTH_KEY',         'MUo(qm}E MdXtd~R8lquXw.BkX|*Upd[C`!n*^fZu:)@suUkoFEMg6I;< %]Gb`9');
define('SECURE_AUTH_KEY',  '^F%]$bM(U/*g{h@E+23Ji>Hn.`Y]t)kl*I[xLHXb-3{3(_8Pgd)-.,m0Q[q2jQ^]');
define('LOGGED_IN_KEY',    'p=GQ^VyOw_, V=~q%!fsL2{/_/r6pc|6N_BZa?<F&c3;^rp9^[GBzyx`b/B6iy}r');
define('NONCE_KEY',        '@`@uL^,n4YH*kU@~w#4^)wD42TD9YylN*Sce&COe^;yO`H8%OpYoY|t_6fxB5!?d');
define('AUTH_SALT',        'mb;b(z3JZ8?v$=fG@e.EAX*!vn[<]Cvk_q+:/0+r@pp8!g*NpSeRp?Ipf3)SBBji');
define('SECURE_AUTH_SALT', '2*Hex|mG0iN$z7vf[e=a/c<5,i)V5.<xwCv@8x)x1iiZ!I;FmY8CP-CR?(sgTlxx');
define('LOGGED_IN_SALT',   'BHf/&|*_SVtLA7P&>GsKcW%WOv{UMe}8K1f7(em-bgil!BE)Wami:mvV;HRT:Bz>');
define('NONCE_SALT',       'mR]0%#~_su#/{[1(YQgI<*bNH+8 SYYQN ~O%(*3Yf.?/AQ5h2iPl!5/ s%Q#Mxf');

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
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );

