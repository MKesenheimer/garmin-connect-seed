#!/bin/bash

devices=$(/usr/bin/grep --color=never 'iq:product id' manifest.xml | sed 's/.*iq:product id="\([^"]*\).*/\1/')
echo $devices
