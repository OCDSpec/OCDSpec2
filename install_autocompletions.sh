#!/usr/bin/env bash

echo "Copying code snippets..."
mkdir -p ~/Library/Developer/Xcode/UserData/CodeSnippets/
cp -R CodeSnippets/ ~/Library/Developer/Xcode/UserData/CodeSnippets/
echo "Done."
