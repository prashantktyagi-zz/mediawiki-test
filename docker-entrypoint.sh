#!/bin/bash

set -e

: ${MEDIAWIKI_SITE_NAME:=mediawiki}
: ${MEDIAWIKI_SITE_LANG:=en}
: ${MEDIAWIKI_ADMIN_USER:=admin}
: ${MEDIAWIKI_ADMIN_PASS:=admin1234}
: ${MEDIAWIKI_DB_TYPE:=mysql}
: ${MEDIAWIKI_DB_NAME:=mediawiki}
: ${MEDIAWIKI_DB_PORT:=3306}
: ${MEDIAWIKI_DB_USER:=mediawiki}
: ${MEDIAWIKI_SITE_SERVER:=localhost:30001}
: ${MEDIAWIKI_SCRIPT_PATH:=/mediawiki}



export MEDIAWIKI_DB_TYPE MEDIAWIKI_DB_HOST MEDIAWIKI_DB_USER MEDIAWIKI_DB_PASSWORD MEDIAWIKI_DB_NAME


cd /var/www/html/mediawiki


# If there is no LocalSettings.php, create one using maintenance/install.php
if [ ! -e "LocalSettings.php" ]; then
	php maintenance/install.php \
		--confpath /var/www/html/${MEDIAWIKI_SITE_NAME} \
		--dbname "$MEDIAWIKI_DB_NAME" \
		--dbport "$MEDIAWIKI_DB_PORT" \
		--dbserver "$MEDIAWIKI_DB_HOST" \
		--dbtype "$MEDIAWIKI_DB_TYPE" \
		--dbuser "$MEDIAWIKI_DB_USER" \
		--dbpass "$MEDIAWIKI_DB_PASSWORD" \
		--installdbuser "$MEDIAWIKI_DB_USER" \
		--installdbpass "$MEDIAWIKI_DB_PASSWORD" \
		--server "$MEDIAWIKI_SITE_SERVER" \
		--scriptpath "$MEDIAWIKI_SCRIPT_PATH" \
		--lang "$MEDIAWIKI_SITE_LANG" \
		--pass "$MEDIAWIKI_ADMIN_PASS" \
		"$MEDIAWIKI_SITE_NAME" \
		"$MEDIAWIKI_ADMIN_USER"

	# move the LocalSettings.php to it
	chown apache:apache LocalSettings.php
fi



exec "$@"