import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/invoice_bloc.dart';
import '../view/ocr_processing_view.dart';

@RoutePage()
class OcrProcessingScreen extends StatelessWidget {
  final String imagePath;

  const OcrProcessingScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<InvoiceBloc>()..add(InvoiceEvent.processImage(imagePath)),
      child: const OcrProcessingView(),
    );
  }
}
