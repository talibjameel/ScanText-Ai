# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# MLKit
-keep class com.google.mlkit.** { *; }
-keep class com.google.android.gms.vision.** { *; }
-dontwarn com.google.mlkit.**
-dontwarn com.google.android.gms.**

# Keep all native methods, their classes and any classes in their descriptors
-keepclasseswithmembers,includedescriptorclasses class * {
    native <methods>;
}

# Keep all classes in google_mlkit_commons
-keep class com.google_mlkit_commons.** { *; }

# Keep all classes in google_mlkit_text_recognition
-keep class com.google_mlkit_text_recognition.** { *; }

# Keep all model files and options
-keep class com.google.mlkit.vision.text.**.options.** { *; }
-keep class com.google.mlkit.vision.text.chinese.** { *; }
-keep class com.google.mlkit.vision.text.devanagari.** { *; }
-keep class com.google.mlkit.vision.text.japanese.** { *; }
-keep class com.google.mlkit.vision.text.korean.** { *; }
-keep class com.google.mlkit.vision.text.latin.** { *; }

# Keep Parcelable classes
-keepclassmembers class * implements android.os.Parcelable {
    static ** CREATOR;
}

# Keep custom exceptions
-keep public class * extends java.lang.Exception

# Keep R8 rules
-keepattributes LineNumberTable,SourceFile
-renamesourcefileattribute SourceFile
