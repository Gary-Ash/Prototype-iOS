#!/usr/bin/env sh
if  [ "${CONFIGURATION}" = "TestFlight" ]; then
	iconDir="${SRCROOT}/${PROJECT_NAME}/Assets.xcassets/AppIcon.appiconset/"
	cp -rf  "${TMPDIR}/${iconDir}" "${iconDir}"
fi
