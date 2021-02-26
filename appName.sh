#!/bin/bash

appName=$(/usr/bin/grep --color=never entry manifest.xml)
appName=$(echo $appName | sed 's/.*entry="\([^"]*\).*/\1/')
echo $appName
