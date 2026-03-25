# 📱 ScanText-AI

A powerful **Flutter-based OCR (Optical Character Recognition)** application that extracts text from images using **Google ML Kit's Text Recognition API**. Transform photos into editable text effortlessly.

---

## ✨ Features

- 📸 **Dual Image Input Methods**
  - Capture images directly from camera
  - Select images from gallery  

- 🤖 **AI-Powered Text Recognition**
  - Real-time OCR using Google ML Kit
  - High-accuracy text extraction
  - Support for multiple languages  

- 🎨 **Modern User Interface**
  - Material Design 3 with dynamic theming
  - Dark mode support
  - Responsive layout
  - Google Fonts integration for elegant typography  

- 📋 **Text Management**
  - Selectable extracted text for easy copying
  - Clear text display in formatted containers
  - Error handling and user feedback  

- 🔐 **Permissions Management**
  - Runtime camera permission requests
  - Proper permission handling

---

## 🛠️ Technology Stack

### Core Framework
- **Flutter** (3.2.3+) - Cross-platform UI framework
- **Dart** - Programming language

### Key Dependencies
- **google_mlkit_text_recognition** (^0.15.0) - OCR engine
- **image_picker** (^1.0.7) - Camera and gallery access
- **permission_handler** (^12.0.0+1) - Permission management
- **google_fonts** (^6.1.0) - Custom typography
- **path_provider** (^2.1.2) - File system access
- **path** (^1.8.3) - Path manipulation utilities
- **cupertino_icons** (^1.0.2) - iOS-style icons

### Development Tools
- **flutter_lints** (^5.0.0) - Code quality rules
- **flutter_launcher_icons** (^0.14.3) - App icon generation

---

## 📁 Project Structure

```
lib/
├── main.dart              # Application entry point & theme setup
└── screens/
    └── home_screen.dart   # Main UI & OCR logic
```

### File Descriptions

#### `lib/main.dart`
- Initializes the Flutter application
- Configures Material 3 theme with blue color scheme (#4A90E2)
- Supports both light and dark themes based on system settings
- Sets up the home screen navigation

#### `lib/screens/home_screen.dart`
- **StatefulWidget** managing the app's core functionality
- **Image Management**: Handles camera and gallery image selection
- **OCR Processing**: Utilizes Google ML Kit TextRecognizer for text extraction
- **UI Components**:
  - AppBar with custom styling
  - Image preview container
  - Camera/Gallery action buttons
  - Processing indicator with progress feedback
  - Text display area with selectable content

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.2.3)
- Dart SDK (included with Flutter)
- Android Studio or Xcode
- iOS 11.0+ or Android 5.0+

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/talibjameel/ScanText-Ai.git
   cd ScanText-Ai
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate app icons**
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Android
- Ensure `android/app/build.gradle` targets Android 5.0+ (API 21+)
- Camera permission is automatically requested at runtime
- ML Kit models are downloaded on first use

#### iOS
- Update `ios/Podfile` to support iOS 11.0+
- Grant camera permissions in `ios/Runner/Info.plist`
- ML Kit dependencies are handled by CocoaPods

---

## 💡 How It Works

### Image Capture Flow
1. User taps **Camera** or **Gallery** button
2. App requests camera permission
3. ImagePicker opens camera/gallery interface
4. Selected image is copied to app's temporary directory
5. `_processImage()` is triggered automatically

### Text Recognition Process
1. Image is converted to `InputImage` format
2. Google ML Kit's `TextRecognizer` processes the image
3. Extracted text is stored in `_extractedText` variable
4. UI updates with recognized text
5. User can select and copy the text

### State Management
- Uses Flutter's built-in `setState()` for UI updates
- Loading indicator shows during processing (`_isProcessing`)
- Proper resource cleanup in `dispose()` method

---

## 📱 Screenshots & UI Flow

### Main Interface
- **Top**: AppBar with "Image to Text" title
- **Middle**: Image preview area (appears after selection)
- **Center**: Camera and Gallery buttons for image selection
- **Bottom**: Extracted text display area with selectable content

### Processing States
1. **Idle**: Buttons visible, no image
2. **Image Selected**: Preview displayed, buttons available
3. **Processing**: Loading spinner shown
4. **Complete**: Extracted text displayed

---

## 🔧 Configuration

### Theme Customization
Edit `lib/main.dart` to modify:
```dart
seedColor: const Color(0xFF4A90E2),  // Change primary color
useMaterial3: true,                   // Material 3 design
```

### App Name
Update in `pubspec.yaml`:
```yaml
name: image_to_text_app  # Change app name here
```

---

## 📚 Dependencies Overview

| Package | Version | Purpose |
|---------|---------|---------|
| flutter | SDK | UI Framework |
| google_mlkit_text_recognition | ^0.15.0 | OCR Engine |
| image_picker | ^1.0.7 | Media Selection |
| permission_handler | ^12.0.0+1 | Permission Management |
| google_fonts | ^6.1.0 | Typography |
| path_provider | ^2.1.2 | File Access |

---

## 🎯 Key Functionalities

### 1. **_pickImage()**
- Requests camera permissions
- Opens ImagePicker dialog
- Handles image selection errors
- Copies image to temporary directory

### 2. **_processImage()**
- Converts image to ML Kit format
- Runs text recognition asynchronously
- Handles processing errors gracefully
- Updates UI with results

### 3. **build()**
- Responsive UI with SingleChildScrollView
- Conditional rendering based on state
- Material Design components
- Accessibility with proper spacing

---

## 🌐 Multi-Platform Support

The app is built to support multiple platforms:
- ✅ **Android** - Fully supported
- ✅ **iOS** - Fully supported  
- ✅ **Web** - Flutter web compatible
- ✅ **Windows** - Flutter desktop compatible
- ✅ **macOS** - Flutter desktop compatible
- ✅ **Linux** - Flutter desktop compatible

---

## 🐛 Error Handling

The application includes:
- **Permission Denial Handling**: Gracefully exits if permissions denied
- **Image Picking Errors**: SnackBar notifications for user feedback
- **OCR Processing Errors**: Displays error messages in text area
- **Resource Cleanup**: Proper disposal of TextRecognizer

---

## 📖 Usage Example

1. Launch the app
2. Grant camera permissions when prompted
3. Tap **Camera** to capture new image or **Gallery** to select existing
4. Wait for ML Kit to process the image
5. Extracted text appears in the text area
6. Long-press or drag to select text
7. Copy text for use in other applications

---

## 🔐 Permissions Required

- **CAMERA**: For capturing images from device camera
- **READ_EXTERNAL_STORAGE**: For accessing gallery images (Android)
- **PHOTO_LIBRARY**: For accessing photo library (iOS)

---

## 🚦 Build & Deployment

### Development Build
```bash
flutter run -d <device_id>
```

### Release Build

**Android:**
```bash
flutter build apk --release
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

---

## 📝 Code Quality

- Flutter linting enabled with `flutter_lints`
- Material Design 3 compliance
- Proper state management with StatefulWidget
- Resource cleanup in dispose methods
- Error handling with try-catch blocks

---

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests
- Improve documentation

---

## 📄 License

This project is open-source. Check LICENSE file for details.

---

## 👤 Author

**Talib Jameel**  
GitHub: [@talibjameel](https://github.com/talibjameel)

---

## 🙏 Acknowledgments

- Google ML Kit for powerful OCR capabilities
- Flutter team for excellent cross-platform framework
- Material Design team for design guidelines

---

## 📞 Support

For issues and questions:
- Open an issue on [GitHub Issues](https://github.com/talibjameel/ScanText-Ai/issues)
- Check existing documentation
- Review code comments for implementation details

---

**Last Updated**: March 2026  
**Version**: 1.0.0  
**Status**: Active Development
