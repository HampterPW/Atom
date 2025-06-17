#!/bin/bash
set -e

APP_NAME=Flappy
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/build/ios"
PAYLOAD_DIR="$BUILD_DIR/Payload"

rm -rf "$BUILD_DIR"
mkdir -p "$PAYLOAD_DIR/$APP_NAME.app"

SDK=$(xcrun --sdk iphoneos --show-sdk-path)

clang++ -std=c++17 -ObjC++ -isysroot "$SDK" \
    -framework UIKit -framework Foundation -framework SDL2 \
    "$ROOT_DIR/flappy/src/main.mm" -o "$PAYLOAD_DIR/$APP_NAME.app/$APP_NAME"

cp "$ROOT_DIR/flappy/Info.plist" "$PAYLOAD_DIR/$APP_NAME.app/"

pushd "$BUILD_DIR" >/dev/null
zip -r "../$APP_NAME.ipa" Payload
popd >/dev/null

