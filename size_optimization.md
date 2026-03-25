# App Size Optimization Guide

## ✅ Already Optimized
- Removed `google_fonts` dependency (was ~2-3MB)
- Using system Roboto font instead
- Cleaned up unused dependencies

## 🚀 Further Size Reduction Steps

### 1. Clean Build (Run these commands)
```bash
flutter clean
flutter pub get
```

### 2. Build with Size Optimization
```bash
# Android Release Build
flutter build apk --release --shrink --split-debug-info=build/debug-info/ --obfuscate

# iOS Release Build  
flutter build ios --release --obfuscate --split-debug-info=build/debug-info/
```

### 3. ProGuard (Android)
Add to `android/app/build.gradle`:
```gradle
android {
    ...
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}
```

### 4. Remove Unused Resources
The main size contributor is `google_mlkit_text_recognition` (~15-20MB) which is necessary for OCR functionality.

### 5. Alternative Lighter OCR Libraries (if needed)
Consider these smaller alternatives:
- `tesseract_ocr` (~8MB) - Open source, smaller
- `flutter_ocr_plugin` (~5MB) - Basic OCR

## 📊 Expected Size After Optimization
- **Current**: ~25-30MB
- **After cleanup**: ~20-25MB  
- **With ProGuard**: ~18-22MB

## 🎯 Quick Fix
Run `flutter clean && flutter pub get && flutter build apk --release --shrink`

This should reduce your app size by 3-5MB immediately!
