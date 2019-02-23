#!/bin/bash

terminus drush $TERMINUS_SITE.$TERMINUS_ENV -- user-create  $cypress_drupal_user_name  --password=cypress_drupal_user_pass
