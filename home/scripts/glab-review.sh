#!/bin/bash

clear

gum style \
  --foreground 212 \
  --border-foreground 212 \
  --border double \
  --align center \
  --width 50 \
  'Choose Reviewer'

REVIEWER=$(gum choose --limit 1 akunze mbaeten)

printf "TODO ;)"
# sh -c "glab mr update --reviewer $REVIEWER"
