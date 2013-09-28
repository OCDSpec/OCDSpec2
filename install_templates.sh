#!/usr/bin/env bash

echo "Create template directory..."
mkdir -p ~/Library/Developer/Xcode/Templates/
echo "Get Templates..."
wget https://github.com/OCDSpec/OCDSpec2/archive/master.zip -O $TMPDIR/master.zip
unzip $TMPDIR/master.zip -d $TMPDIR
echo "Copying template files..."
cp -R $TMPDIR/OCDSpec2-master/Templates/ ~/Library/Developer/Xcode/Templates/
cd ..
echo "Delete Temporary files"
rm -rf $TMPDIR/OCDSpec2-master
rm $TMPDIR/master.zip
echo "Done."
