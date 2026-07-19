#!/usr/bin/env bash
set -euo pipefail

source /etc/profile.d/devkit-env.sh
cd /build_dir

# Download makerom and ctrtool.
curl -fL \
  -o makerom_016_ctrtool.zip \
  "https://github.com/3DSGuy/Project_CTR/releases/download/v0.16/makerom_016_ctrtool.zip"

# The devkitPro image already includes unzip.
unzip -jo makerom_016_ctrtool.zip \
  "Ubuntu/makerom" \
  "Ubuntu/ctrtool" \
  -d /usr/local/bin

chmod +x /usr/local/bin/makerom
chmod +x /usr/local/bin/ctrtool

# Build rehid.
make clean
make -j2

# Put the finished module where the artifact uploader expects it.
mkdir -p 0004013000001D02
mv 0004013000001D02.cxi \
  0004013000001D02/0004013000001D02.cxi
