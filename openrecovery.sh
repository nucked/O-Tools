#!/bin/sh

writescript(){
  if [ $1 == "data" ]; then
    rm -fr /tmp/openrecoveryscript
    touch /tmp/openrecoveryscript
    echo -e 'wipe data' > openrecoveryscript
    echo -e 'wipe cache' >> openrecoveryscript
    echo -e 'wipe dalvik' >> openrecoveryscript
    adb shell rm -f /cache/recovery/openrecoveryscript
    adb push /tmp/openrecoveryscript /cache/recovery/openrecoveryscript
  elif [ $1 == "backup" ]; then
    rm -fr /tmp/openrecoveryscript
    touch /tmp/openrecoveryscript
    NAME=${date +"%F-%I-%H-%N"}
    echo -e 'backup SBDO $NAME' > openrecoveryscript
    adb shell rm -f /cache/recovery/openrecoveryscript
    adb push /tmp/openrecoveryscript /cache/recovery/openrecoveryscript
 elif [ $1 == "sideload" ]; then
   rm -fr /tmp/openrecoveryscript
   touch /tmp/openrecoveryscript
   echo -e 'install /sdcard/update.zip' > openrecoveryscript
   adb shell rm -f /cache/recovery/openrecoveryscript
   adb push /tmp/openrecoveryscript /cache/recovery/openrecoveryscript
   adb shell rm -fr /sdcard/update.zip
   adb push $updatezip /sdcard/update.zip
 fi
 adb reboot bootloader
 fastboot devices
 fastboot boot res/$adbdevice/recovery.img
}

if [$1 == "--sideload" ]; then
  writescript sideload
elif [ $1 == "--data" ]; then
  writescript data
elif [ $1 == "--backup" ]; then
  writescript backup
elif [ $1 == "--data-zip" ]; then
  writescript data
  writescript sideload
elif [ $1 == "--backup-zip" ]; then
  writescript backup
  writescript sideload
elif [ $1 == "--backup-data" ]; then
  writescript backup
  writescript data
elif [ $1 == "--full" ]; then
  writescript backup
  writescript data
  writescript sideload
else
fi
