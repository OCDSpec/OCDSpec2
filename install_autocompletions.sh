#!/usr/bin/env bash
echo "Create snippet directory..."
mkdir -p ~/Library/Developer/Xcode/UserData/CodeSnippets/
echo "Get Snippets"
wget https://github.com/OCDSpec/OCDSpec2/archive/master.zip -O $TMPDIR/master.zip
unzip $TMPDIR/master.zip -d $TMPDIR
echo "Copying snippet files..."
cp -R $TMPDIR/OCDSpec2-master/CodeSnippets/ ~/Library/Developer/Xcode/UserData/CodeSnippets/
cd ..
echo "Delete Temporary files"
rm -rf $TMPDIR/OCDSpec2-master
rm $TMPDIR/master.zip
echo "Done."
