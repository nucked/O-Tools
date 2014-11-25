#!/system/bin/bash
if [ -d /dev/block/platform/sdhci-tegra.3/by-name/app ]
  then
  touch /tmp/fake
  echo -e '0' > /tmp/fake
elif [ -d /dev/block/platform/sdhci-tegra.4/by-name/app ]
  then
  touch /tmp/fake
  echo -e '0' > /tmp/fake
else
  touch /tmp/fake
  echo -e '1' > /tmp/fake
fi
