#!/bin/sh
sudo echo "? Sudo password :"

echo "? webserver username (e.g. www-data?) :"
read APACHEUSER

echo "- Updating composer"
php composer.phar self-update
echo "- Running composer.phar install"
php composer.phar -q install --prefer-dist

echo "- Removing ezpublish/{cache,logs}"
rm -rf ezpublish/cache
rm -rf ezpublish/logs

echo "- Creating ezpublish/{cache,logs}"
mkdir -p ezpublish/cache
mkdir -p ezpublish/logs

echo "- Applying user:group rights"
sudo chmod +a "$APACHEUSER allow delete,write,append,file_inherit,directory_inherit" \
     ezpublish/{cache,logs,config} ezpublish_legacy/{design,extension,settings,var} web
sudo chmod +a "`whoami` allow delete,write,append,file_inherit,directory_inherit" \
     ezpublish/{cache,logs,config} ezpublish_legacy/{design,extension,settings,var} web

echo "- ezpublish/console -q assets:install --symlink web"
sudo -u www php ezpublish/console -q assets:install --symlink web
echo "- ezpublish/console -q ezpublish:legacy:assets_install --symlink web"
sudo -u www php ezpublish/console -q ezpublish:legacy:assets_install --symlink web
echo "- ezpublish/console -q assetic:dump --env=prod web"
sudo -u www php ezpublish/console -q assetic:dump --env=prod web
