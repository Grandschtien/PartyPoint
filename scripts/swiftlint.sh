#!/bin/bash

SOURCES_PATH="Targets/PartyPoint/Sources"

if which swiftlint > /dev/null; then
swiftlint --path $SOURCES_PATH --config ../.swiftlint.yml --quiet
else
echo "warning: SwiftLint is not installed. Please install it first"
fi
