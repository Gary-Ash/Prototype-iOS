#!/usr/bin/env sh
if  [ "${CONFIGURATION}" = "TestFlight" ]; then
	iconDir="$SRCROOT/$PROJECT_NAME/Assets.xcassets/AppIcon.appiconset/"

	mkdir -p "${TMPDIR}/${iconDir}"
	cp -rf "${iconDir}" "${TMPDIR}/${iconDir}"
	for file in $(find "$iconDir" -name "*.png" -type f); do
		width=$(magick identify -format %w "$file")
		if  [ "$width" = 1024 ]; then
			largeIcon="$file"
			break
		fi
	done

	echo "$SRCROOT/$INFOPLIST_FILE"
	version=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$INFOPLIST_FILE")
	build=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "$INFOPLIST_FILE")

	magick convert "$largeIcon" "$SRCROOT/BuildEnv/Beta.png" -gravity northwest -geometry +0+0 -composite "$largeIcon"
	magick convert -background '#0008' -fill white -font helvetica -gravity center -size 1024x50 -pointsize 30 caption:"v${version}\n${build}" "$largeIcon" +swap -gravity south -composite "$largeIcon"

	for file in $(find "$iconDir" -name "*.png" -type f); do
		dim=$(magick identify -format "%wx%h" "$file")
		if  [ "$dim" != "1024x1024" ]; then
			magick convert "$largeIcon" -resize "$dim!" "$file"
		fi
	done
fi
