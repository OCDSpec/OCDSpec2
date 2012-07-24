#!/usr/bin/env bash

echo "Copying templates..."
mkdir -p ~/Library/Developer/Xcode/Templates/
cp -R Templates/ ~/Library/Developer/Xcode/Templates/
echo "Copying code snippets..."
mkdir -p ~/Library/Developer/Xcode/UserData/CodeSnippets/
cp -R CodeSnippets/ ~/Library/Developer/Xcode/UserData/CodeSnippets/
echo "Done."
