#!/usr/bin/env bash

echo "Copying file template..."
dest="$HOME/Library/Developer/Xcode/Templates/SpecKit-Templates/File Templates/SpecKit/Spec.xctemplate"
mkdir -p "$dest"
cp "Templates/Spec.xctemplate/"* "$dest"
echo "Done."

echo "Copying iOS target template..."
dest="$HOME/Library/Developer/Xcode/Templates/SpecKit-Templates/Project Templates/SpecKit/iOS Spec Runner.xctemplate"
mkdir -p "$dest"
cp "Templates/iOS Spec Runner.xctemplate"/* "$dest"
echo "Done."

echo "Copying Mac target template..."
dest="$HOME/Library/Developer/Xcode/Templates/SpecKit-Templates/Project Templates/SpecKit/Mac Spec Runner.xctemplate"
mkdir -p "$dest"
cp "Templates/Mac Spec Runner.xctemplate"/* "$dest"
echo "Done."
