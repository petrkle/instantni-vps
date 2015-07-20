<?php
define('DB_TYPE', 'mysql');
define('DB_HOST', 'localhost');
define('DB_USER', 'ttrss');
define('DB_NAME', 'ttrss');
define('DB_PASS', '{{ pillar.mysql.ttrss_password}}');
define('DB_PORT', '3306');
define('MYSQL_CHARSET', 'UTF8');
define('SELF_URL_PATH', 'https://rss.kle.cz/');
define('FEED_CRYPT_KEY', 'a4sd415asd5f^Nasdf68+23G');
define('SINGLE_USER_MODE', false);
define('SIMPLE_UPDATE_MODE', false);
define('PHP_EXECUTABLE', '/usr/bin/php');
define('LOCK_DIRECTORY', 'lock');
define('CACHE_DIR', 'cache');
define('ICONS_DIR', "feed-icons");
define('ICONS_URL', "feed-icons");
define('AUTH_AUTO_CREATE', true);
define('AUTH_AUTO_LOGIN', true);
define('FORCE_ARTICLE_PURGE', 0); 
define('PUBSUBHUBBUB_HUB', '');
define('PUBSUBHUBBUB_ENABLED', false);
define('SPHINX_SERVER', 'localhost:9312');
define('SPHINX_INDEX', 'ttrss, delta');
define('ENABLE_REGISTRATION', false);
define('REG_NOTIFY_ADDRESS', 'user@your.domain.dom');
define('REG_MAX_USERS', 10);
define('SESSION_COOKIE_LIFETIME', 86400);
define('SESSION_CHECK_ADDRESS', 1); 
define('SMTP_FROM_NAME', 'Tiny Tiny RSS');
define('SMTP_FROM_ADDRESS', 'noreply@your.domain.dom');
define('DIGEST_SUBJECT', '[tt-rss] New headlines for last 24 hours');
define('SMTP_SERVER', '');
define('SMTP_LOGIN', '');
define('SMTP_PASSWORD', '');
define('SMTP_SECURE', '');
define('CHECK_FOR_UPDATES', false);
define('DETECT_ARTICLE_LANGUAGE', false);
define('ENABLE_GZIP_OUTPUT', false);
define('PLUGINS', 'auth_internal, note');
define('LOG_DESTINATION', 'sql');
define('CONFIG_VERSION', 26);
