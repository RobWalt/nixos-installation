#!/bin/bash

question () {
  gum confirm --prompt.width=50 --prompt.align=center --default "$1"
}

gumprint () {
  gum style \
    --foreground 212 \
    --border-foreground 212 \
    --border double \
    --align center \
    --width 50 \
    "$1"
}

short_long() {
  gumprint "$1" && question "$2" && clear
}

clear

short_long "Fixes" "Did you fix everything in the issue?" \
&& short_long "Tests" "Did you write tests for new functionality?" \
&& short_long "Clippy" "Is clippy happy?" \
&& short_long "Cleanup" "Did you remove logs & prints?" \
&& short_long "Cleanup" "Are there any TODOs left?" \
&& gumprint "Good Job!"
