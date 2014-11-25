#!/bin/bash
term=$(cat runat)
if [[ $1 == "--shell" ]]; then
  $term -e './XTools.sh --shell'
elif [[ $1 == "--backup" ]]; then
    $term -e './XTools.sh --backup'
elif [[ $1 == "--restore" ]]; then
  $term -e './XTools.sh --restore'
elif [[ $1 == "--push" ]]; then
  $term -e './XTools.sh --push'
elif [[ $1 == "--camera" ]]; then
  $term -e './XTools.sh --camera'
elif [[ $1 == "--apk" ]]; then
  $term -e './XTools.sh --apk'
elif [[ $1 == "--srec" ]]; then
  $term -e './XTools.sh --srec'
elif [[ $1 == "--runtime" ]]; then
  $term -e './XTools.sh --runtime'
elif [[ $1 == "--recovery" ]]; then
  $term -e './XTools.sh --debug'
elif [[ $1 == "--recovery" ]]; then
  $term -e './XTools.sh --recovery'
elif [[ $1 == "--flash" ]]; then
  $term -e './XTools.sh --flash'
elif [[ $1 == "--root" ]]; then
  $term -e './XTools.sh --root'
elif [[ $1 == "--fastboot" ]]; then
  $term -e './XTools.sh --fastboot'
elif [[ $1 == "--wipe" ]]; then
  $term -e './XTools.sh --wipe'
elif [[ $1 == "--device" ]]; then
  $term -e './XTools.sh --device'
elif [[ $1 == "--about" ]]; then
  $term -e './XTools.sh --about'
elif [[ $1 == "--debug" ]]; then
  $term -e './XTools.sh --debug'
fi
