import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'package:image_picker/image_picker.dart';

import 'package:camera/camera.dart';

class CaptureInvoiceView extends StatefulWidget {
  const CaptureInvoiceView({super.key});

  @override
  State<CaptureInvoiceView> createState() => _CaptureInvoiceViewState();
}

class _CaptureInvoiceViewState extends State<CaptureInvoiceView> {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        _controller = CameraController(
          _cameras.first,
          ResolutionPreset.high,
          enableAudio: false,
        );
        await _controller!.initialize();
        if (mounted) {
          setState(() {
            _isReady = true;
          });
        }
      }
    } catch (e) {
      debugPrint('Error initializing camera: \$e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final XFile picture = await _controller!.takePicture();
      if (mounted) {
        context.router.push(OcrProcessingRoute(imagePath: picture.path));
      }
    } catch (e) {
      debugPrint('Error taking picture: \$e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Error al tomar la foto')));
      }
    }
  }

  Future<void> _pickGallery() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && mounted) {
      context.router.push(OcrProcessingRoute(imagePath: image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady || _controller == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Camera View
          Positioned.fill(child: CameraPreview(_controller!)),
          // 2. Overlay Frames (semi-transparent backgrounds with clear center)
          Positioned.fill(
            child: Column(
              children: [
                Expanded(child: Container(color: Colors.black54)),
                SizedBox(
                  height: 400,
                  child: Row(
                    children: [
                      Container(width: 32, color: Colors.black54),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.8,
                                  ),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            // Corners
                            _buildCorner(Alignment.topLeft),
                            _buildCorner(Alignment.topRight),
                            _buildCorner(Alignment.bottomLeft),
                            _buildCorner(Alignment.bottomRight),
                            // Tip Text
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Encuadra tu recibo',
                                  style: AppTypography.labelMedium.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 32, color: Colors.black54),
                    ],
                  ),
                ),
                Expanded(child: Container(color: Colors.black54)),
              ],
            ),
          ),
          // 3. Top Gradient & Actions
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      // Navigate to index 0 (Home) of BottomNav or pop
                      context.router.navigate(const HomeRoute());
                    },
                  ),
                  Text(
                    'Captura de Factura',
                    style: AppTypography.titleLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.flash_off, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          // 4. Bottom Controls (Shutter, etc)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                bottom: 100,
                top: 48,
                left: 24,
                right: 24,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.black87, Colors.transparent],
                ),
              ),
              child: Column(
                children: [
                  // Mode Switch
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Lote',
                        style: AppTypography.labelMedium.copyWith(
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.3),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Única',
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Gallery button
                      GestureDetector(
                        onTap: _pickGallery,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.photo_library,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // Shutter button
                      GestureDetector(
                        onTap: _takePicture,
                        child: Container(
                          width: 80,
                          height: 80,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.photo_camera,
                              color: AppColors.primary,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      // Magic button
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border(
            top:
                (alignment == Alignment.topLeft ||
                    alignment == Alignment.topRight)
                ? const BorderSide(color: AppColors.primary, width: 4)
                : BorderSide.none,
            bottom:
                (alignment == Alignment.bottomLeft ||
                    alignment == Alignment.bottomRight)
                ? const BorderSide(color: AppColors.primary, width: 4)
                : BorderSide.none,
            left:
                (alignment == Alignment.topLeft ||
                    alignment == Alignment.bottomLeft)
                ? const BorderSide(color: AppColors.primary, width: 4)
                : BorderSide.none,
            right:
                (alignment == Alignment.topRight ||
                    alignment == Alignment.bottomRight)
                ? const BorderSide(color: AppColors.primary, width: 4)
                : BorderSide.none,
          ),
          borderRadius: BorderRadius.only(
            topLeft: alignment == Alignment.topLeft
                ? const Radius.circular(8)
                : Radius.zero,
            topRight: alignment == Alignment.topRight
                ? const Radius.circular(8)
                : Radius.zero,
            bottomLeft: alignment == Alignment.bottomLeft
                ? const Radius.circular(8)
                : Radius.zero,
            bottomRight: alignment == Alignment.bottomRight
                ? const Radius.circular(8)
                : Radius.zero,
          ),
        ),
      ),
    );
  }
}
