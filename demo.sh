#!/bin/bash

export TERMINUS_SITE=$1
export TERMINUS_ENV=$2
export CYPRESS_DRUPAL_USERNAME=$3
export CYPRESS_baseUrl="https://${TERMINUS_ENV##*/}-${TERMINUS_SITE}.pantheonsite.io/"
export CYPRESS_DRUPAL_USERPASS=$(openssl rand -base64 32)


terminus -q drush $TERMINUS_SITE.$TERMINUS_ENV -- user-create  $CYPRESS_DRUPAL_USERNAME  --password=$CYPRESS_DRUPAL_USERPASS
terminus -q drush $TERMINUS_SITE.$TERMINUS_ENV -- user-password $CYPRESS_DRUPAL_USERNAME --password=$CYPRESS_DRUPAL_USERPASS
terminus -q drush $TERMINUS_SITE.$TERMINUS_ENV -- user-add-role  administrator  $CYPRESS_DRUPAL_USERNAME


npx cypress run --headed
