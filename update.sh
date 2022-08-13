#!/bin/bash

gum \
  confirm \
  --default "Do you want to update nixos?" \
  --prompt.align=center \
  && nixos-rebuild switch \
  && dunstify \
  "SYSTEM UPDATE FINISHED" \
  "Nixos was successfully updated" \
  -u critical \
  -t 10000
