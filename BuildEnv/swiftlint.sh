#!/usr/bin/env sh

if [ "${CONFIGURATION}" = "Debug" ]; then
    if which swiftlint >/dev/null; then
		 find "$SRCROOT" -type f -name "*.swift" -print0 | xargs -0 swiftlint --fix --config "$PROJECT_DIR/.swiftlint.yml" --path 
    else
        echo "warning: SwiftLint not installed,  brew install SwiftLint"
    fi
fi
