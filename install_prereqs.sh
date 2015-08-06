#!/bin/bash

case $1 in
  ("homebrew")
    brew install cmake pkg-config gmp openblas && easy_install pip ;;
  ("macports")
    port install cmake gmp openblas && easy_install pip;;
  ("ubuntu")
    apt-get install cmake build-essential libgmp-dev python-pip liblapack-dev libblas-dev gfortran ;;
  ("cygwin")
    cygwin-setup -q -P make pkg-config libgmp-devel ;;
  (*)
    echo "Usage: ./install_prereqs.sh package_manager"
    echo "where package_manager is one of the following: "
    echo "  homebrew"
    echo "  macports"
    echo "  ubuntu"
    echo "  cygwin"
    exit 1 ;;
esac

pip install -r python_requirements.txt

SUBDIRS="drake externals"
for subdir in $SUBDIRS; do
  if [ -f $subdir/install_prereqs.sh ]; then
    echo "installing prereqs for $subdir"
    ( cd $subdir; ./install_prereqs.sh $1 || true )
  fi
done