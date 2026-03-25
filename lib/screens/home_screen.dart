import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  File? _image;
  String _extractedText = '';
  bool _isProcessing = false;
  final _textRecognizer = TextRecognizer();
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _textRecognizer.close();
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final status = await Permission.camera.request();
    if (status.isDenied) {
      _showModernSnackBar('Camera permission denied. Please enable it in settings.');
      return;
    }

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      
      if (image != null) {
        // Create a copy of the image in the app's temporary directory
        final tempDir = await getTemporaryDirectory();
        final fileName = path.basename(image.path);
        final tempImage = File(path.join(tempDir.path, fileName));
        await tempImage.writeAsBytes(await image.readAsBytes());

        setState(() {
          _image = tempImage;
          _extractedText = '';
          _isProcessing = true;
        });

        _slideController.forward();
        await _processImage();
      }
    } catch (e) {
      _showModernSnackBar('Error picking image: $e');
    }
  }

  void _showModernSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFba9eff), Color(0xFF699cff)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message,
            style: const TextStyle(
              color: Color(0xFF1a0033),
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _processImage() async {
    if (_image == null) return;

    try {
      final inputImage = InputImage.fromFile(_image!);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      
      setState(() {
        _extractedText = recognizedText.text;
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _isProcessing = false;
        _extractedText = 'Error processing image: $e';
      });
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
      _extractedText = '';
      _isProcessing = false;
    });
    _slideController.reset();
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _extractedText));
    _showModernSnackBar('Text copied to clipboard!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060e20),
      appBar: AppBar(
        leading:  Padding(
          padding: EdgeInsets.only(left: 10),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFba9eff), Color(0xFF699cff)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Color(0xFF1a0033),
              size: 24,
            ),
          ),
        ),
        title: Text(
          'Scan TextAI',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Color(0xFFdee5ff),
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        // actions: [
        //   Container(
        //     margin: const EdgeInsets.only(right: 16),
        //     decoration: BoxDecoration(
        //       color: const Color(0xFF141f38).withValues(alpha:0.6),
        //       borderRadius: BorderRadius.circular(16),
        //       border: Border.all(
        //         color: const Color(0xFFba9eff).withValues(alpha:0.2),
        //         width: 1,
        //       ),
        //     ),
        //     child: IconButton(
        //       icon: const Icon(
        //         Icons.person_outline,
        //         color: Color(0xFFdee5ff),
        //       ),
        //       onPressed: () {},
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero Section
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF141f38).withValues(alpha: 0.8),
                      const Color(0xFF192540).withValues(alpha:0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFba9eff).withValues(alpha:0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'TextLens',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFdee5ff),
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Unlock the potential of your text',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFa3aac4),
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Scanner Area
              if (_image != null) ...[
                Stack(
                  children: [
                    SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFFba9eff).withValues(alpha:0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFba9eff).withValues(alpha:0.2),
                              blurRadius: 20,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Stack(
                            children: [
                              Image.file(
                                _image!,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              if (_isProcessing)
                                Container(
                                  color: Colors.black.withValues(alpha:0.7),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFFba9eff),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Remove Image Button
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: _removeImage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha:0.7),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFba9eff).withValues(alpha:0.3),
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Color(0xFFdee5ff),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ] else ...[
                // Empty Scanner State
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xFF141f38).withValues(alpha:0.4),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFFba9eff).withValues(alpha:0.2),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFba9eff), Color(0xFF699cff)],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFba9eff).withValues(alpha:0.3),
                                    blurRadius: 20,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Color(0xFF1a0033),
                                size: 48,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF699cff),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Ready to scan',
                            style: const TextStyle(
                              color: Color(0xFFa3aac4),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Action Buttons
              Column(
                children: [
                  _buildModernButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: Icons.camera_alt,
                    label: 'SCAN NOW',
                    isPrimary: true,
                  ),
                  const SizedBox(height: 16),
                  _buildModernButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: Icons.photo_library_outlined,
                    label: 'Open Gallery',
                    isPrimary: false,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Extracted Text Section
              if (_extractedText.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF141f38).withValues(alpha:0.9),
                        const Color(0xFF192540).withValues(alpha:0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFFba9eff).withValues(alpha:0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF000000).withValues(alpha:0.3),
                        blurRadius: 12,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Extracted Text',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFdee5ff),
                              fontFamily: 'Roboto',
                            ),
                          ),
                          IconButton(
                            onPressed: _copyToClipboard,
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFba9eff).withValues(alpha:0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.copy,
                                color: Color(0xFFba9eff),
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF060e20).withValues(alpha:0.6),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF334155).withValues(alpha:0.3),
                            width: 1,
                          ),
                        ),
                        child: SelectableText(
                          _extractedText,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Color(0xFFdee5ff),
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required bool isPrimary,
  }) {
    if (isPrimary) {
      return AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _pulseAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFba9eff), Color(0xFF699cff)],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFba9eff).withValues(alpha:0.4),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: onPressed,
                icon: Icon(
                  icon,
                  color: const Color(0xFF1a0033),
                  size: 28,
                ),
                label: Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF1a0033),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xFF141f38).withValues(alpha:0.6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFba9eff).withValues(alpha:0.3),
            width: 1,
          ),
        ),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: const Color(0xFFba9eff),
            size: 24,
          ),
          label: Text(
            label,
            style: const TextStyle(
              color: Color(0xFFba9eff),
              fontWeight: FontWeight.w600,
              fontSize: 14,
              fontFamily: 'Roboto',
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
      );
    }
  }
}
