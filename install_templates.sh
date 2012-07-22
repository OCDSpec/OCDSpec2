#!/usr/bin/env bash

dest="$HOME/Library/Developer/Xcode/Templates/SpecKit-Templates/File Templates/SpecKit/Spec.xctemplate"
mkdir -p "$dest"
cp Spec.xctemplate/* "$dest"
echo "Done."
