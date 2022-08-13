#!/bin/bash

source /etc/nixos/home/scripts/utils.sh

gum_print "What is the target branch?"

TARGET_BRANCH=$(gum choose --limit 1 master other)

case $TARGET_BRANCH in 
  *master* ) ;;
  * ) TARGET_BRANCH=$(git branch --list | gum filter);;
esac

gum_print "Who should be the reviewer?"

REVIEWER=$(gum choose --limit 1 akunze mbaeten gkougianos abott)

gum_print "Continuing with normal glab MR creation ..."

glab mr create --target-branch $TARGET_BRANCH --reviewer $REVIEWER
