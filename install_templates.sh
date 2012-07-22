#!/usr/bin/env bash

echo "Copying file template..."
dest="$HOME/Library/Developer/Xcode/Templates/SpecKit-Templates/File Templates/SpecKit/Spec.xctemplate"
mkdir -p "$dest"
cp Spec.xctemplate/* "$dest"
echo "Done."

echo "Copying target template..."
dest="$HOME/Library/Developer/Xcode/Templates/SpecKit-Templates/Project Templates/SpecKit/Mac Spec Runner.xctemplate"
mkdir -p "$dest"
cp "Mac Spec Runner.xctemplate"/* "$dest"
echo "Done."
