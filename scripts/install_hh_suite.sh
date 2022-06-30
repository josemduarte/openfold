#!/bin/bash

set -e

if [ -z "$1" ]
then
  echo "Usage: $0 <target install dir> [-l]"
  echo "Install hh-suite to provided target install dir. If second argument is -l, then a symlink to /usr/bin is created"
  exit 1
fi

install_dir=$1
TMP_DIR=/tmp/hh-suite

git clone --branch v3.3.0 https://github.com/soedinglab/hh-suite.git $TMP_DIR \
  && mkdir $TMP_DIR/build \
  && cd $TMP_DIR/build \
  && cmake -DCMAKE_INSTALL_PREFIX="$install_dir" .. \
  && make -j 4 && make install \


if [ "$2" = "-l" ]
then
  ln -s "$install_dir"/bin/* /usr/bin
fi

rm -rf $TMP_DIR
