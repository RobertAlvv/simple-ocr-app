import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/error_view.dart';
import '../bloc/invoice_bloc.dart';

class OcrProcessingView extends StatefulWidget {
  const OcrProcessingView({super.key});

  @override
  State<OcrProcessingView> createState() => _OcrProcessingViewState();
}

class _OcrProcessingViewState extends State<OcrProcessingView> {
  /// Tracks elapsed seconds for progressive timeout hints.
  int _elapsedSeconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _elapsedSeconds = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() => _elapsedSeconds = t.tick);
    });
  }

  void _stopTimer() => _timer?.cancel();

  /// Returns a contextual hint based on how long the user has been waiting.
  String _progressHint() {
    if (_elapsedSeconds >= 25) {
      return 'Sigue intentando… esto puede tomar un poco más.';
    }
    if (_elapsedSeconds >= 10) {
      return 'Esto está tardando más de lo usual…';
    }
    return 'Extrayendo datos usando IA\nPor favor espera un momento.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<InvoiceBloc, InvoiceState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (invoice) {
              _stopTimer();
              context.router.replace(
                ExtractedDataReviewRoute(invoiceId: invoice.id),
              );
            },
            error: (_, kind) => _stopTimer(),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            error: (message, kind) {
              return ErrorView(
                message: message,
                kind: kind,
                onRetry: () {
                  // Re-dispatch the original processImage event
                  final bloc = context.read<InvoiceBloc>();
                  final currentEvent = _extractImagePath(bloc);
                  if (currentEvent != null) {
                    _startTimer();
                    bloc.add(InvoiceEvent.processImage(currentEvent));
                  }
                },
                onBack: () => context.router.pop(),
              );
            },
            orElse: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: AppColors.primary),
                  const SizedBox(height: 32),
                  Text(
                    'Analizando factura...',
                    style: AppTypography.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: Text(
                      _progressHint(),
                      key: ValueKey(_elapsedSeconds >= 25
                          ? 'hint-25'
                          : _elapsedSeconds >= 10
                              ? 'hint-10'
                              : 'hint-0'),
                      style: AppTypography.bodyMedium.copyWith(
                        color: _elapsedSeconds >= 10
                            ? AppColors.warning
                            : AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Attempts to extract the original imagePath from the bloc so we can retry.
  /// We peek at the most recent ProcessImage event stored in the screen's
  /// parent (OcrProcessingScreen passes it via the bloc constructor).
  String? _extractImagePath(InvoiceBloc bloc) {
    // The OcrProcessingScreen creates the bloc with:
    //   getIt<InvoiceBloc>()..add(InvoiceEvent.processImage(imagePath))
    // We navigate to this screen WITH the imagePath, so we can access it
    // from the route parameters.
    final route = context.router.current;
    // AutoRoute stores path params; our route has `imagePath` as a param
    try {
      return (route.args as OcrProcessingRouteArgs).imagePath;
    } catch (_) {
      return null;
    }
  }
}
