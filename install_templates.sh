#!/usr/bin/env bash

if [ $1 == "local" ]
then
  echo "Copying template files..."
  cp -R Templates/ ~/Library/Developer/Xcode/Templates/
  echo "Done."
else
  echo "Create template directory..."
  mkdir -p ~/Library/Developer/Xcode/Templates/
  echo "Get Templates..."
  cd $TMPDIR
  curl -LOk https://github.com/OCDSpec/OCDSpec2/archive/master.zip
  cd -
  unzip $TMPDIR/master.zip -d $TMPDIR
  echo "Copying template files..."
  cp -R $TMPDIR/OCDSpec2-master/Templates/ ~/Library/Developer/Xcode/Templates/
  cd ..
  echo "Delete Temporary files"
  rm -rf $TMPDIR/OCDSpec2-master
  rm $TMPDIR/master.zip
  echo "Done."
fi
