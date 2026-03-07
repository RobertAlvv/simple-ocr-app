import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../view/camera_capture_view.dart';

@RoutePage()
class CameraCaptureScreen extends StatelessWidget {
  const CameraCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CameraCaptureView();
  }
}
