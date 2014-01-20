#!/usr/bin/env bash

if [ $1 == "local" ]
then
  echo "Copying snippet files..."
  cp -R CodeSnippets/ ~/Library/Developer/Xcode/UserData/CodeSnippets/
  echo "Done."
else
  echo "Create snippet directory..."
  mkdir -p ~/Library/Developer/Xcode/UserData/CodeSnippets/
  echo "Get Snippets"
  cd $TMPDIR
  curl -LOk https://github.com/OCDSpec/OCDSpec2/archive/master.zip
  cd -
  unzip $TMPDIR/master.zip -d $TMPDIR
  echo "Copying snippet files..."
  cp -R $TMPDIR/OCDSpec2-master/CodeSnippets/ ~/Library/Developer/Xcode/UserData/CodeSnippets/
  cd ..
  echo "Delete Temporary files"
  rm -rf $TMPDIR/OCDSpec2-master
  rm $TMPDIR/master.zip
  echo "Done."
fi
