#!/bin/sh
updatePath=$1
updateName=$2
updateEFIPath=$3
updateEFIName=$4

rm "/System/Library/CoreServices/Firmware Updates/*"
cp "$updateEFIPath" "/System/Library/CoreServices/Firmware Updates"
if [[ $? != 0 ]]; then
    exit -1
fi
cp "$updatePath" "/System/Library/CoreServices/Firmware Updates"
if [[ $? != 0 ]]; then
    exit -1
fi
chmod -R 777 "/System/Library/CoreServices/Firmware Updates"
bless -mount / -firmware "/System/Library/CoreServices/Firmware Updates/$updateEFIName" -payload "/System/Library/CoreServices/Firmware Updates/$updateName" -options "-x efi-apple-payload0-data" --verbose
if [[ $? != 0 ]]; then
    exit -2
fi
