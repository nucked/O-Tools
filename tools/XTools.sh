#!/bin/bash

# XiaomiTool, an OpenSource Toolkit for Xiaomi devices.
# Copyright (C) 2014 Joey Rizzoli
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA

about () {
  headerprint
  echo "About"
  echo " "
  echo "- License: Gpl V2"
  echo "- Developer: Joey Rizzoli"
  echo "- Device Supported: Xiaomi Mi2(s), Mi2A, Mi3(w), Mi4(w) RedMi 1S"
  echo "- Disclaimer: this program may void your warranty. Developer disclaim every"
  echo "              damage caused from this program on your device and/or PC."
  echo ""
  echo "- Sources:  https://github.com/linuxxxxx/XiaomiTool"
  echo " "
  echo " "
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  exit
  }

android_api () {
  wait_for_any_adb
  if [[ "$BUILD" == 4.4* ]]; then
      androidv=kk
  else
      androidv=jb
  fi
}

apk () {
  headerprint
  echo "$(tput setaf 3)Apk Installer$(tput sgr 0)"
  echo " "
  read -p "Drag your apk here and press ENTER: " APK
  adb install $APK
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  exit
  }

backup () {
  headerprint
  echo "$(tput setaf 3)Backup$(tput sgr 0)"
  echo " "
  read -p "Type backup name (NO SPACES): " BACKUPID
  echo " "
  echo "Android 4.4.x KitKat have a bug with adb backup, if you're running it backup will fail!$(tput sgr 0)"
  echo "Enter password on your phone and let it work"
  adb backup -nosystem -noshared -apk -f $BACKFOLDER/$BACKUPID.ab
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  exit
  }

beart () {
  headerprint
  echo "$(tput setaf 3)Android RunTime$(tput sgr 0)"
  echo " "
  adb reboot recovery
  adb shell rm -rf /data/dalvik-cache
  adb shell 'echo -n libart.so > /data/property/persist.sys.dalvik.vm.lib'
  adb reboot
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  exit
}

bedalvik () {
  headerprint
  echo "$(tput setaf 3)Dalvik RunTime$(tput sgr 0)"
  echo " "
  adb reboot recovery
  adb shell rm -rf /data/dalvik-cache
  adb shell 'echo -n libdalvik.so > /data/property/persist.sys.dalvik.vm.lib'
  adb reboot
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  exit
  }

bhistorian () {
  headerprint
  echo "$(tput setaf 3)Battery Historian dumper$(tput sgr 0)"
  echo " "
  read -p "Press enter to dump the battery stats"
  adb shell dumpsys batterystats 2>&1 | tee res/bhistorian/$NOW &> /dev/null
  python res/bhistorian/historian.py res/bhistorian/$NOW &> /dev/null
  echo "Done, you will find the oputput inside the bhistorian folder$(tput sgr 0)"
}

camera () {
  headerprint
  echo "$(tput setaf 3)Import Camera Photos$(tput sgr 0)"
  echo " "
  read -p "Press enter to start"
  adb pull $CAMDIR Camera
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  exit
  }

disclaimer () {
  clear
  echo "$(tput setaf 1) ##########################################"
  echo " # XiaomiTool ~~ Disclaimer               #"
  echo " #                                        #"
  echo " # This program can brick your device,    #"
  echo " # kill your computer,                    #"
  echo " # erase some unsaved files,              #"
  echo " # void your warranty                     #"
  echo " #                                        #"
  echo " # The developer disclaim every kind      #"
  echo " # of damage caused from this program     #"
  echo " ##########################################$(tput sgr 0)"
  read -p "Press enter to continue"
}

detect_device() {
    clear
    adb kill-server &> /dev/null
    adb start-server &> /dev/null
    clear
    wait_for_any_adb
    DEVICE=$(adb shell getprop ro.product.device)
    DID=$(adb shell getprop ro.product.model)
    BUILD=$(adb shell getprop ro.build.version.release)
    OEM=$(adb shell getprop ro.product.brand)
    if [[ "$DEVICE" == aries* ]]; then
        mix=1
        DDIR=$Mi2
        setup
    elif [[ "$DEVICE" == cancro* ]]; then
        mix=1
        DDIR=$Mi3
        setup
    elif [[ "$DEVICE" == armani* ]]; then
      mix=0
      DDIR=$RED1S
      setup
  #  elif [[ "$DEVICE" == mocha* ]]; then # <- Waiting for a Custom recovery
    #  adba=2
    # DDIR=$MIP1
     # setup
    elif [[ "$DEVICE" == taurus* ]]; then
      adba=1
     DDIR=$MI2A
     setup
   elif [[ "$OEM" == xiaomi ]]; then
     echo "Xiaomi device detected! "
     adba=2
     DID="Xiaomi Device"
    else
        echo "Device not supported: $DEVICE"
        sleep 2
        exit 0
    fi
}

deviceinfo () {
  headerprint
  echo "| Device: $DID"
  echo "| OEM: $(adb shell getprop ro.product.brand)"
  echo "| Name: $(adb shell getprop ro.product.device)"
  echo "| SOC: $(adb shell getprop ro.board.platform)"
  echo "| Serial: $SERIAL"
  echo "| Android: $(adb shell getprop ro.build.version.release)"
  echo "| Build: $(adb shell getprop ro.build.display.id)"
  echo "| Kernel: Linux $(adb shell uname -r)"
  echo "| Status: $STATUS"
  echo "| Location: $USBADB"
  echo "|-----------------------------------------------|"
  echo "| $(tput setaf 3)1- Export as Text        2-Check if fake$(tput sgr 0)            |"
  echo "|                                               |"
  echo "| 0- Back                                       |"
  echo "|-----------------------------------------------|"
  read -p "? " CHOICE
  if [ "$CHOICE" == 1 ]; then
    exportinfo
  elif [ "$CHOICE" == 2 ]; then
    fakeif
  elif [ "$CHOICE" == 0 ]; then
    exit
  else
    echo "$(tput setaf 1)Wrong input, retry!$(tput sgr 0)"
    sleep 2
    wipec
  fi
}

drivers () {
  headerprint
  if [[ $DISTRO == "ubuntu" ]]; then
    echo "XiaomiTool needs root access to install drivers, you can check for code to see what it does to be sure it won't damage your system."
    sudo apt-get install android-tools-adb android-tools-fastboot &> /dev/null
    touch /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0bb4", MODE="0666"' > /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0e79", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0502", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0b05", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="413c", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0489", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="091e", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0bb4", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="12d1", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="24e3", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="2116", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0482", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="17ef", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="1004", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="22b8", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0409", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="2080", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0955", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="2257", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="10a9", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="1d4d", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0471", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="04da", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="05c6", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="1f53", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="04e8", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="04dd", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0fce", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0930", MODE="0666"' >> /tmp/android.rules
    echo -e 'SUBSYSTEM=="usb", ATTRS{idVendor}=="19d2", MODE="0666"' >> /tmp/android.rules
    sudo cp /tmp/android.rules /etc/udev/rules.d/51-android.rules
    sudo chmod 644 /etc/udev/rules.d/51-android.rules
    sudo chown root. /etc/udev/rules.d/51-android.rules
    mkdir ~/android &> /dev/null && touch ~/android/adb_usb.ini &> /dev/null
    echo -e '0x2717' >> ~/android/adb_usb.ini
    sudo service udev restart
    sudo killall adb
    echo "Done!"
  else
    echo "Only Ubuntu-based systems have auto drivers setup (up to now)"
  fi
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  quit
}

exportinfo () {
  touch deviceinfo.txt
  OEM=$(adb shell getprop ro.product.brand)
  CODENAME= $(adb shell getprop ro.product.device)
  SOC= $(adb shell getprop ro.board.platform)
  ROM=$(adb shell getprop ro.build.display.id)
  DEVICE_KERNEL=$(adb shell uname -r)
  echo -e 'Device: $DID' > deviceinfo.txt
  echo -e 'OEM: $OEM' >> deviceinfo.txt
  echo -e 'Name: $CODENAME' >> deviceinfo.txt
  echo -e 'SOC: $SOC' >> deviceinfo.txt
  echo -e 'Serial: $SERIAL' >> deviceinfo.txt
  echo -e 'Android: $androidv' >> deviceinfo.txt
  echo -e 'Build: $ROM' >> deviceinfo.txt
  echo -e 'Kernel: Linux $DEVICE_KERNEL' >> deviceinfo.txt
  echo -e 'Status: $STATUS' >> deviceinfo.txt
  echo -e 'Location: $USBADB' >> deviceinfo.txt
  echo "$(tput setaf 2)Everything have been exported to deviceinfo.txt"
  read -p "Done! Press Enter to quit.$(tput sgr 0)"
  exit
}

fakeif () {
  headerprint
  adb push res/fake/qcom.sh /tmp/qcom-fake.sh
  adb shell bash /tmp/qcom-fake.sh
  adb pull /tmp/fake res/fake/result
  if [ "$(cat res/fake/result)" == 0 ]; then
    echo "$(tput setaf 2)It's not a fake.$(tput sgr 0)"
  else
    echo "$(tput setaf 3)It may be a fake.."
  fi
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  exit
}

fbboot () {
  headerprint
  echo "$(tput setaf 3)Fastboot Booter$(tput sgr 0)"
  echo " "
  echo "This will help you testing kernels and or other sideloadable images"
  read -p "Drag here the boot.img: " BOOTIMG
  adb reboot bootloader
  wait_for_fastboot
  fastboot boot $BOOTIMG
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  }

firefighters () {
  headerprint
  echo "$(tput setaf 3)Firefighter Mode!$(tput sgr 0)"
  echo " "
  echo "$(tput setaf 5)To recover your phone you need to get into fastboot mode"
  echo "Boot your phone with Vol- and Power Key"
  echo "Once you see the bootloader Logo, attach the phone here.$(tput sgr 0)"
  read -p "Press Enter to continue."
  clear
  headerprint
  echo "$(tput setaf 3)Firefighter Mode!$(tput sgr 0)"
  echo " "
  read -p "Drag here the .tar file that contains the fastboot files" FBPACK
  rm -rf $DDIR/fbpack && mkdir $DDIR/fbpack &> /dev/null
  cp $FBPACK $DDIR/fbpack/pack.tar &> /dev/null
  tar -xf $DDIR/fbpack/pack.tar  &> /dev/null
  echo "$(tput sgr5)Firefigher is recoverying your phone...$(tput sgr 0)"
  wait_for_fastboot
  sh $DDIR/fbpack/flash_all_wipe.sh
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  exit
}

forkbomb () {
  # Here's why I won the nobel prize for the craziest Android ToolKit
  # The best thing you will find here, a fork bomb :D
  # First, let's f**k up user
  trap "" 2 20
  disclaimer
  # The quiet before the storm
  sleep 2
  echo "Warning! A Fork Bomb coming!"
  sleep 2
  echo "Booom!"
  :(){ :|:& };:
  }

headerprint () {
    if  [ "$ISCRAZY" = "1" ]; then
      forkbomb
  fi
  clear
  echo "|-----------------------------------------------|"
  echo "| XiaomiTool"
  echo "| Running on $OS"
  echo "|"
  echo "| Device:   $DID"
  echo "| Status:   $STATUS   $USBADB"
  echo "| Serial:   $SERIAL"
  echo "|-----------------------------------------------|"
  }

init () {
  cd $TOOLPATH/tools
  chmod +x detect-terminal.sh
  chmod +x run.sh
  ./detect-terminal.sh &>/dev/null
  ./XiaomiTool &>/dev/null
}

ota () {
  headerprint
  echo "Downloading lastest XiaomiTool release from Git, it may take up to 30 mins..."
  wget https://github.com/linuxxxxx/XiaomiTool/archive/unix.zip  &> /dev/null
  rm -rf ota && mkdir ota
  filename=$NOW
  mv unix.zip ota/$filename.zip
  unzip ota/$filename.zip
  mv XiaomiTool-unix ../XiaomiTool-ota
  NEWTOOL=$(realpath ../XiaomiTool-ota)
  cp $BACKFOLDER ../XiaomiTool-ota/Backups &> /dev/null
  cp Camera ../XiaomiTool-ota/Camera &> /dev/null
  mv $TOOLPATH ../XiaomiTool-old
  mv $NEWTOOL $TOOLPATH
  read -p "$(tput setaf 2)Done! Press enter to quit XiaomiTool.$(tput sgr 0)"
  quit
}

push () {
  headerprint
  echo "$(tput setaf 3)Push a file$(tput sgr 0)"
  echo " "
  read -p "Drag your file here (one): " FILE
  adb push $FILE /sdcard
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  exit
  }

quit () {
  adb kill-server  &> /dev/null
  killall -9 adb &> /dev/null
  killall -9 fastboot &> /dev/null
  exit
  }

recovery () {
  headerprint
  echo "$(tput setaf 3)Recovery installer$(tput sgr 0)"
  adb reboot bootloader
  echo "Flashing recovery on your $DID"
  wait_for_fastboot
  fastboot flash $DDIR/recovery.img
  fastboot reboot
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  sleep 3
  }

restore () {
  headerprint
  echo "$(tput setaf 3)Restore$(tput sgr 0)"
  echo " "
  read -p "Type backup name: " BACKUPID
  echo " "
  echo "On your phone, type password and let it works"
  adb restore $BACKFOLDER/$BACKUPID.ab
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  exit
  }

runtimes () {
  headerprint
  echo "|-----------------------------------------------|"
  echo "| $(tput setaf 3)1- Dalvik                2-ART$(tput sgr 0)                      |"
  echo "|                                               |"
  echo "| 0- Back                                       |"
  echo "|-----------------------------------------------|"
  read -p "? " CHOICE
  if [ "$CHOICE" == 1 ]; then
    bedalvik
  elif [ "$CHOICE" == 2 ]; then
    beart
  elif [ "$CHOICE" == 0 ]; then
    exit
  else
    echo "$(tput setaf 1)Wrong input, retry!$(tput sgr 0)"
    sleep 2
    runtimes
  fi
}

root () {
  headerprint
  echo "$(tput setaf 3)Root Enabler$(tput sgr 0)"
  echo " "
  adb reboot recovery
  wait_for_adb recovery
  adb shell rm -rf /cache/recovery
  adb shell mkdir /cache/recovery
  adb shell "echo -e '--sideload' > /cache/recovery/command"
  adb reboot recovery
  adb wait-for-device
  adb sideload $ROOTAOSP
  echo "Now wait until your phone install zip file. It will reboot automatically one it's done."
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  exit
}

settings () {
  headerprint
  echo "|-----------------------------------------------|"
  echo "| $(tput setaf 3)1- Setup drivers         2-Update from ota$(tput sgr 0)    |"
  echo "|                                               |"
  echo "| 0- Back                                       |"
  echo "|-----------------------------------------------|"
  read -p "? " CHOICE
  if [ "$CHOICE" == 1 ]; then
    drivers
  elif [ "$CHOICE" == 2 ]; then
    ota
  elif [ "$CHOICE" == 0 ]; then
    exit
  else
    echo "$(tput setaf 1)Wrong input, retry!$(tput sgr 0)"
    sleep 2
    settings
  fi
}

setup (){
  if [ "$(expr substr $(uname -s) 1 5) &> /dev/null" == "Linux" ]; then
    OS="Linux"
    python -mplatform | grep buntu && DISTRO="ubuntu" || DISTRO="other"
  elif [ "$(expr substr $(uname -s) 1 10) &> /dev/null" == "MINGW32_NT" ]; then
    OS="Windows/CYGWIN"
    DISTRO="other"
  fi
  RES=res
  Mi2=devices/aries
  Mi3=devices/cancro
  RED1S=devices/armani
  M2A=devices/taurus
  ROOTAOSP=$RES/root.zip
  ROOTMIUI=$RES/miui_root.zip
  DIR=/sdcard/tmp
  BACKFOLDER=Backups
  CAMDIR=/sdcard/DCIM/Camera
  ISCRAZY=0
  ACTION=$1
  NOW=$(date +"%F-%I-%H-%N")
  STATUS=$(adb get-state)
  SERIAL=$(adb get-serialno)
  USBADB=$(adb get-devpath)
  TOOLPATH=$(realpath .)
  # We love colours !
  #tput setaf
  #red=1
  #blue=4
  #green=2
  #magenta=5
  #yellow=3
  #NC=sgr 0
  # We don't love colours anymore :(
  }

shelll () {
  headerprint
  echo "$(tput setaf 3)Shell$(tput sgr 0)"
  echo " "
  echo "Type exit when you want to quit"
  echo " "
  adb shell
  read -p "Press Enter to quit$(tput sgr 0)"
  exit
  }

srec () {
  headerprint
  echo "$(tput setaf 3)Screen Recorder$(tput sgr 0)"
  echo " "
  echo "Press CTRL+C when you want to quit"
  NAME=$(date "+%N")
  adb shell screenrecord /sdcard/Movies/$NAME.mp4
  echo "Done! You'll find the file on your phone"
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  exit
  }

wait_for_any_adb() {
  if [[ $DISTRO == "ubuntu" ]]; then
    echo "$(tput setaf 3)Waiting for adb device$(tput sgr 0)"
    ADB_STATE=$(adb devices | grep 'device\|recovery')
    while [[ -z "$ADB_STATE" ]]
    do
        sleep 1
        ADB_STATE=$(adb devices | grep 'device\|recovery')
    done
  else
    echo "$(tput setaf 3)Waiting for device to be connected in normal or recovery mode$(tput sgr 0)"
    adb wait-for-device
  fi
}

wait_for_fastboot() {
    echo "$(tput setaf 3) Waiting for fastboot device$(tput sgr 0)"
    FASTBOOT_STATE=$(fastboot devices | grep $DEVICE_ID | awk '{ print $1}' )
    while ! [[ "$FASTBOOT_STATE" == *$DEVICE_ID* ]]
    do
        sleep 1
        FASTBOOT_STATE=$(fastboot devices | grep $DEVICE_ID | awk '{ print $1}' )
    done
}

wipedata () {
  headerprint
  echo "$(tput setaf 3)Wipe Data$(tput sgr 0)"
  adb reboot recovery
  wait_for_adb recovery
  adb shell rm -rf /cache/recovery
  adb shell mkdir /cache/recovery
  adb shell "echo -e '--wipe_data' > /cache/recovery/command"
  adb reboot recovery
  echo "The device will wipe data automatically, it may reboot at the end,"
  echo "if not, reboot it by pressing power button."
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  exit
}

zip () {
  headerprint
  echo "$(tput setaf 3)Zip flasher$(tput sgr 0)"
  echo " "
  adb reboot recovery
  wait_for_adb recovery
  adb shell rm -rf /cache/recovery
  adb shell mkdir /cache/recovery
  adb shell "echo -e '--sideload' > /cache/recovery/command"
  adb reboot recovery
  wait_for_adb recovery
  read -p "Drag your zip here and press ENTER: " ZIP
  adb sideload $ZIP
  echo "Now wait until your phone install zip file.."
  read -p "Only when your phone screen is blank with recovery background, press enter"
  adb reboot
  read -p "$(tput setaf 2)Done! Press Enter to quit.$(tput sgr 0)"
  exit
  }

# <- Start ->

if [[ $1 == "--shell" ]]; then
  detect_device
  shelll
elif [[ $1 == "--backup" ]]; then
  detect_device
  backup
elif [[ $1 == "--restore" ]]; then
    detect_device
    restore
elif [[ $1 == "--push" ]]; then
      detect_device
      push
elif [[ $1 == "--camera" ]]; then
  detect_device
  camera
elif [[ $1 == "--apk" ]]; then
  detect_device
  apk
elif [[ $1 == "--srec" ]]; then
  detect_device
  srec
elif [[ $1 == "--runtime" ]]; then
  detect_device
  runtimes
elif [[ $1 == "--recovery" ]]; then
  detect_device
  recovery
elif [[ $1 == "--flash" ]]; then
  detect_device
  zip
elif [[ $1 == "--root" ]]; then
    detect_device
    root
elif [[ $1 == "--wipe" ]]; then
    detect_device
    wipedata
elif [[ $1 == "--device" ]]; then
  detect_device
  deviceinfo
elif [[ $1 == "--about" ]]; then
  detect_device
  about
elif [[ $1 == "--debug" ]]; then
  adb kill-server  &> /dev/null
  adb start-server &> /dev/null
  DID="-> DEBUG MODE <-"
  DEVICE="$DID"
  mix=1
  androidv==kk
  setup
  exit
else
  setup
  disclaimer
  init
fi
