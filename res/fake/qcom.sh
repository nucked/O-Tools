#!/system/bin/bash
if [ -d /dev/block/platform/msm_sdcc.1 ]
  then
  touch /tmp/fake
  echo -e '0' > /tmp/fake
elif [ -d /dev/block/platform/msm_sdcc.3 ]
  then
  touch /tmp/fake
  echo -e '0' > /tmp/fake
else
    touch /tmp/fake
    echo -e '1' > /tmp/fake

fi
