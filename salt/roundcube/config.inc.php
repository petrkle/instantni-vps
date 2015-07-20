<?php

/* Local configuration for Roundcube Webmail */

// ----------------------------------
// SQL DATABASE
// ----------------------------------
// Database connection string (DSN) for read+write operations
// Format (compatible with PEAR MDB2): db_provider://user:password@host/database
// Currently supported db_providers: mysql, pgsql, sqlite, mssql or sqlsrv
// For examples see http://pear.php.net/manual/en/package.database.mdb2.intro-dsn.php
// NOTE: for SQLite use absolute path: 'sqlite:////full/path/to/sqlite.db?mode=0646'
$config['db_dsnw'] = 'sqlite:////usr/share/nginx/roundcubemail.db?mode=0646';

// log driver:  'syslog' or 'file'.
$config['log_driver'] = 'syslog';

// Syslog facility to use, if using the 'syslog' log driver.
// For possible values see installer or http://php.net/manual/en/function.openlog.php
$config['syslog_facility'] = LOG_MAIL;

// ----------------------------------
// IMAP
// ----------------------------------
// The mail host chosen to perform the log-in.
// Leave blank to show a textbox at login, give a list of hosts
// to display a pulldown menu or set one host as string.
// To use SSL/TLS connection, enter hostname with prefix ssl:// or tls://
// Supported replacement variables:
// %n - hostname ($_SERVER['SERVER_NAME'])
// %t - hostname without the first part
// %d - domain (http hostname $_SERVER['HTTP_HOST'] without the first part)
// %s - domain name after the '@' from e-mail address provided at login screen
// For example %n = mail.domain.tld, %t = domain.tld
// WARNING: After hostname change update of mail_host column in users table is
//          required to match old user data records with the new host.
$config['default_host'] = 'ssl://{{ pillar.mailname }}';

// ----------------------------------
// SMTP
// ----------------------------------
// SMTP server host (for sending mails).
// To use SSL/TLS connection, enter hostname with prefix ssl:// or tls://
// If left blank, the PHP mail() function is used
// Supported replacement variables:
// %h - user's IMAP hostname
// %n - hostname ($_SERVER['SERVER_NAME'])
// %t - hostname without the first part
// %d - domain (http hostname $_SERVER['HTTP_HOST'] without the first part)
// %z - IMAP domain (IMAP hostname without the first part)
// For example %n = mail.domain.tld, %t = domain.tld
$config['smtp_server'] = 'tls://{{ pillar.mailname }}';

// SMTP username (if required) if you use %u as the username Roundcube
// will use the current username for login
$config['smtp_user'] = '%u';

// SMTP password (if required) if you use %p as the password Roundcube
// will use the current user's password for login
$config['smtp_pass'] = '%p';

// provide an URL where a user can get support for this Roundcube installation
// PLEASE DO NOT LINK TO THE ROUNDCUBE.NET WEBSITE HERE!
$config['support_url'] = 'http://support.{{ pillar.base_mail_domain }}';

// e.g. array( 'localhost:11211', '192.168.1.12:11211', 'unix:///var/tmp/memcached.sock' );
// check client IP in session athorization
$config['ip_check'] = true;

// this key is used to encrypt the users imap password which is stored
// in the session record (and the client cookie if remember password is enabled).
// please provide a string of exactly 24 chars.
$config['des_key'] = 'aafs684!$?7565afdzdasdfN';

// Name your service. This is displayed on the login screen and in the window title
$config['product_name'] = '{{ pillar.webmail_url }}';

// ----------------------------------
// PLUGINS
// ----------------------------------
// List of active plugins (in plugins/ directory)
$config['plugins'] = array(
	'managesieve',
);

// the default locale setting (leave empty for auto-detection)
// RFC1766 formatted language name like en_US, de_DE, de_CH, fr_FR, pt_BR
$config['language'] = 'cs_CZ';

// Make use of the built-in spell checker. It is based on GoogieSpell.
// Since Google only accepts connections over https your PHP installatation
// requires to be compiled with Open SSL support
$config['enable_spellcheck'] = false;

// prefer displaying HTML messages
$config['prefer_html'] = false;

// compose html formatted messages by default
// 0 - never, 1 - always, 2 - on reply to HTML message, 3 - on forward or reply to HTML message
$config['htmleditor'] = 2;

// default setting if preview pane is enabled
$config['preview_pane'] = true;

// Encoding of long/non-ascii attachment names:
// 0 - Full RFC 2231 compatible
// 1 - RFC 2047 for 'name' and RFC 2231 for 'filename' parameter (Thunderbird's default)
// 2 - Full 2047 compatible
$config['mime_param_folding'] = 0;

// Behavior if a received message requests a message delivery notification (read receipt)
// 0 = ask the user, 1 = send automatically, 2 = ignore (never send or ask)
// 3 = send automatically if sender is in addressbook, otherwise ask the user
// 4 = send automatically if sender is in addressbook, otherwise ignore
$config['mdn_requests'] = 2;
$rcmail_config['useragent'] = '{{ pillar.webmail_url }}';
