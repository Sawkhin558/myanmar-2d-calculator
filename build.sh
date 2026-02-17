#!/bin/bash

# Simple build script for Myanmar 2D Calculator Android APK
# Usage: ./build.sh [debug|release]

set -e

MODE=${1:-debug}

echo "🔨 Building Myanmar 2D Calculator in $MODE mode..."

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
  echo "📦 Installing npm dependencies..."
  npm install
fi

# Add Android platform if missing
if [ ! -d "android" ]; then
  echo "📱 Adding Android platform..."
  npx cap add android
fi

# Sync web assets to native project
echo "🔄 Syncing web assets..."
npx cap sync

# Build the APK
echo "🏗️  Building APK..."
cd android

if [ "$MODE" = "release" ]; then
  echo "Building RELEASE APK (requires signing config)..."
  ./gradlew assembleRelease
  APK_PATH="app/build/outputs/apk/release/app-release.apk"
else
  echo "Building DEBUG APK..."
  ./gradlew assembleDebug
  APK_PATH="app/build/outputs/apk/debug/app-debug.apk"
fi

cd ..

if [ -f "$APK_PATH" ]; then
  echo "✅ APK built successfully!"
  echo "📁 Location: $(pwd)/$APK_PATH"
  echo "📤 Transfer this file to your Android phone to install."
else
  echo "❌ Build failed - check error messages above."
  exit 1
fi
