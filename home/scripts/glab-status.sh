#!/bin/bash

clear

gum style \
  --foreground 212 \
  --border-foreground 212 \
  --border double \
  --align center \
  --width 50 \
  'Getting GitLab Labels'

LABELS=$(glab label list -P 10000 \
  | rg "^ .*" \
  | rg ".*\S.*" \
  | sd '^ (.*)' '$1' \
  | sd '\->' '' \
  | sd '\s+$' '\n'
)

WANTED=$(gum choose --no-limit $LABELS)
UNWANTED=$(comm -23 \ 
  <(sort <(printf "%s\n" $LABELS)) \
  <(sort <(printf "%s\n" $WANTED))
)

clear

gum style \
  --foreground 212 \
  --border-foreground 212 \
  --border double \
  --align center \
  --width 50 \
  'Choose Issue'

NRISS=$(glab issue list -P 10000 \
  | rg "#[0-9]*" \
  | sd '(#[0-9]*.*)about.*' '$1' \
  | sd '(#[0-9]*.*)\(.*' '$1' \
  | gum filter
)

NRISS=$(echo $NRISS | sd '#([0-9]*).*' '$1')

clear

printf "TODO ;)"
# sh -c glab issue update $NRISS -u $UNWANTED -l $WANTED
