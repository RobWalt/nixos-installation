#!/bin/bash

clear

gum style \
  --foreground 212 \
  --border-foreground 212 \
  --border double \
  --align center \
  --width 50 \
  'Getting GitLab Information' \
  'Choose Categories'

GETTHIS=$(gum choose --no-limit issues merges)

clear

gum style \
  --foreground 212 \
  --border-foreground 212 \
  --border double \
  --align center \
  --width 50 \
  'Getting GitLab Information' \
  'Author or Assignee?'

CHOSEN=$(gum choose --limit 1 author assignee)

clear

case "$CHOSEN" in 
  *author* ) THEFLAG="--author=@me" ;;
  *assignee* ) THEFLAG="--assignee=@me" ;;
  * ) THEFLAG="";;
esac

case "$GETTHIS" in 
  *issues* ) gum spin --spinner points --show-output -- sh -c "glab issue list $THEFLAG" ;;
esac

case "$GETTHIS" in 
  *merges* ) gum spin --spinner points --show-output -- sh -c "glab mr list $THEFLAG" ;;
esac
