# Myanmar 2D Calculator - Android APK Build Guide

This is a Progressive Web App (PWA) wrapped with Capacitor to build a native Android APK.

## Prerequisites (Install Once)

1. **Node.js** (v18+)
   - Download from https://nodejs.org

2. **Android Studio**
   - Download from https://developer.android.com/studio
   - During install: Check "Android SDK" and "Android Virtual Device"
   - After install: Open Android Studio → SDK Manager → Install:
     - Android SDK Platform 34 (or latest)
     - Android SDK Build-Tools
     - Android Platform-Tools

3. **Set environment variables** (add to ~/.bashrc or ~/.zshrc):
```bash
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/build-tools/34.0.0
```
Then run: `source ~/.bashrc` (or restart terminal)

4. **Accept Android licenses**:
```bash
flutter doctor --android-licenses  # if you have Flutter
# OR
sdkmanager --licenses
```

---

## Build Steps

### 1. Install Dependencies
```bash
cd myanmar-2d-calculator
npm install
```

### 2. Add Android Platform (First time only)
```bash
npx cap add android
```
This creates `android/` folder.

### 3. Sync Web Assets
```bash
npx cap sync
```
This copies your `index.html` to the Android project.

### 4. Build APK

**Option A: Using Android Studio (GUI - Recommended for beginners)**
```bash
npx cap open android
```
- Android Studio opens with your project
- Wait for Gradle sync to complete (bottom status bar)
- Menu: **Build → Build Bundle(s) / APK(s) → Build APK(s)**
- APK location: `android/app/build/outputs/apk/debug/app-debug.apk`
- For release (smaller, can install without debug): Build → Generate Signed Bundle/APK

**Option B: Command Line Only**
```bash
cd android
./gradlew assembleDebug
# APK: android/app/build/outputs/apk/debug/app-debug.apk
```

---

## Install APK on Your Phone

1. Transfer `app-debug.apk` to your phone
2. Enable "Install from unknown sources" for your file manager/browser
3. Open the APK file and install

---

## Quick One-Command Build (After setup)

```bash
npm run sync && cd android && ./gradlew assembleDebug
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `npx: command not found` | Install Node.js properly |
| `Android SDK not found` | Set ANDROID_HOME env variable |
| Gradle sync fails | Open Android Studio → File → Sync Project with Gradle Files |
| "Unknown error" during build | In Android Studio: Build → Clean Project, then rebuild |
| APK won't install | Enable "Unknown sources" in phone settings |

---

## Notes

- **Debug APK**: `app-debug.apk` - for testing, larger, requires USB debugging for some features
- **Release APK**: `app-release.apk` - smaller, can distribute, needs signing key
- The app uses **localStorage** to save data. On Android, this persists across app restarts but **uninstalling the app will delete all data**.
- Internet permission is required (html2canvas loads from CDN). Add this to `android/app/src/main/AndroidManifest.xml` if missing:
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

---

## Create Icon Files (PNG) from SVG

If you don't have image conversion tools, use an online converter:
- Upload `icon.svg` to https://convertio.co/svg-png/
- Convert to:
  - `icon-192.png` (192x192)
  - `icon-512.png` (512x512)
- Place them in this folder (same directory as index.html)

---

## Need Help?

Check: `android/app/build/outputs/apk/` for your APK.

Happy calculating! 🧮
