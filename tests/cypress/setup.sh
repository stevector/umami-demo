#!/bin/bash

terminus drush $TERMINUS_SITE.$TERMINUS_ENV -- user-create  $CYPRESS_DRUPAL_USERNAME  --password=$CYPRESS_DRUPAL_USERPASS
terminus drush $TERMINUS_SITE.$TERMINUS_ENV -- user-add-role  administrator  $CYPRESS_DRUPAL_USERNAME
