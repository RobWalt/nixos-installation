#!/bin/bash

source $HOME/.mygumscripts/utils.sh

clear

gum_print 'Getting GitLab Labels'

ALL_LABELS=$(glab label list -P 10000 \
  | rg "^ .*" \
  | rg ".*\S.*" \
  | sd '^ (.*)' '$1' \
  | sd '\->' '' \
  | sd '\s+$' '\n'
)

clear

gum_print 'Choose Issue'

NR_ISS=$(glab issue list -P 10000 \
  | rg "#[0-9]*" \
  | sd '(#[0-9]*.*)about.*' '$1' \
  | sd '(#[0-9]*.*)\(.*' '$1' \
  | gum filter
)

NR_ISS=$(echo $NR_ISS | sd '#([0-9]*).*' '$1')

clear

gum_print "Getting labels"

EXIST_LABELS=$(glab issue view $NR_ISS | rg -i "label" | sd '.*:\W*(.*)' '$1' | sd ', ' '\n')

DESELECT=$(printf "%s" "$EXIST_LABELS" | rusty-gum)

SELECT=$(printf "%s" "$ALL_LABELS" | rusty-gum)

if [ -z $SELECT ] && [ -z $DESELECT ] 
then
  printf "Nothing selected at all"
elif [ -z $SELECT ] 
then
  glab issue update $NR_ISS -u $DESELECT
elif [ -z $DESELECT ]
then
  glab issue update $NR_ISS -l $SELECT
else
  glab issue update $NR_ISS -l $SELECT -u $DESELECT
fi
