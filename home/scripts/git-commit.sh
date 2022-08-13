#!/bin/bash

source /etc/nixos/home/scripts/utils.sh

check_for_commit() {
  COMMITTED_STUFF=$(git commit --dry-run | rg "no changes added to commit")
  printf "\n$COMMITTED_STUFF\n"
  RET=0
  case $COMMITTED_STUFF in 
    *"no changes"* ) RET=$(gum confirm "No changes were committed. Do you want to add everything?" && git add -A);;
    * ) RET=0;;
  esac
  return $RET
}

check_for_commit
SHOULD_CONTINUE=$?

if [ $SHOULD_CONTINUE -eq 0 ]; then

  FILTER_CHOOSE_OUTPUT=""
  filter_choose "feature fix documentation style refactor tests chore" "Choose type of commit"

  PREFIX=""
  case $FILTER_CHOOSE_OUTPUT in 
    *feature* ) PREFIX="feat" ;;
    *fix* ) PREFIX="fix" ;;
    *documentation* ) PREFIX="docs" ;;
    *style* ) PREFIX="style" ;;
    *refactor* ) PREFIX="refactor" ;;
    *tests* ) PREFIX="tests" ;;
    *chore* ) PREFIX="chore" ;;
    * )  ;;
  esac

  gum_print "Current commit: $PREFIX"
  gum_print "Describe scope/subject of commit:"
  SUBJECT=$(gum input --placeholder "Scope/Subject")

  clear

  gum_print "Current commit: $PREFIX($SUBJECT):"
  gum_print "Describe summary of commit:"
  SUMMARY=$(gum input --placeholder "Summary" --char-limit=50)

  clear

  gum_print "Current commit: $PREFIX($SUBJECT): $SUMMARY"
  gum_print "Describe details of commit:"
  DETAILS=$(gum write --placeholder "Details ..." --show-line-numbers)

  clear

  FIRST="$PREFIX($SUBJECT): $SUMMARY"
  SECOND="$DETAILS"

  git commit -m "$FIRST" -m "$SECOND"
else
  gum_print "You have to add some changes manually then!"
fi
