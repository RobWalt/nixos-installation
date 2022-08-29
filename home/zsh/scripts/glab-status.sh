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

DESELECT=""
NEW_DESELECT=""
FIRST_WITHOUT_SECOND_OUTPUT=""

while [[ ! $NEW_DESELECT = "CONTINUE" ]]
do
  DESELECT="$NEW_DESELECT $DESELECT"
  FIRST_WITHOUT_SECOND_OUTPUT=$(comm -23 <(sort <(printf "%s\n" $EXIST_LABELS)) <(sort <(printf "%s\n" $DESELECT)))
  NEW_DESELECT=$(printf "%s\n" "CONTINUE" "$FIRST_WITHOUT_SECOND_OUTPUT" | gum filter --placeholder "Which labels should be deselected?")
done

SELECT=""
NEW_SELECT=""
FIRST_WITHOUT_SECOND_OUTPUT=""

while [[ ! $NEW_SELECT = "CONTINUE" ]]
do
  SELECT="$NEW_SELECT $SELECT"
  UNWANTED="$SELECT $EXIST_LABELS"
  FIRST_WITHOUT_SECOND_OUTPUT=$(comm -23 <(sort <(printf "%s\n" $ALL_LABELS)) <(sort <(printf "%s\n" $UNWANTED)))
  NEW_SELECT=$(printf "%s\n" "CONTINUE" "$FIRST_WITHOUT_SECOND_OUTPUT" | gum filter --placeholder "Which labels should be selected?")
done

glab issue update $NR_ISS -u $DESELECT -l $SELECT
