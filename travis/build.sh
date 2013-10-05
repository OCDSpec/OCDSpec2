#!/bin/sh
set -e

xctool -project OCDSpec2.xcodeproj -scheme OCDSpec2 -sdk iphonesimulator
xctool -project OCDSpec2.xcodeproj -scheme OCDSpec2Specs -sdk iphonesimulator
