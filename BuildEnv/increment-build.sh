#!/usr/bin/env sh
if [ "${CONFIGURATION}" = "Release" ] || [ "${CONFIGURATION}" = "TestFlight" ]; then
	CFBundleVersion=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "${INFOPLIST_FILE}")
	BuildNumber=$(echo $CFBundleVersion | awk -F "." '{print $3}')
	BuildNumber=$(($BuildNumber + 1))
	CFBundleVersion=$(echo $CFBundleVersion | awk -F "." '{print $1 "." $2 ".'$BuildNumber'"}')
	/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $CFBundleVersion" "${INFOPLIST_FILE}"
fi
