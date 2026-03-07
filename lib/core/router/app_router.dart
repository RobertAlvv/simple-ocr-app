import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'guards/auth_guard.dart';

// ── Screen imports ───────────────────────────────────────
import '../../features/auth/presentation/screen/login_screen.dart';
import '../../features/home/presentation/screen/shell_screen.dart';
import '../../features/home/presentation/screen/home_screen.dart';
import '../../features/invoice/presentation/screen/capture_invoice_screen.dart';
import '../../features/invoice/presentation/screen/ocr_processing_screen.dart';
import '../../features/invoice/presentation/screen/extracted_data_review_screen.dart';
import '../../features/invoice/presentation/screen/invoice_detail_screen.dart';
import '../../features/invoice/presentation/screen/camera_capture_screen.dart';
import '../../features/expense/presentation/screen/expense_history_screen.dart';
import '../../features/analytics/presentation/screen/analytics_screen.dart';
import '../../features/settings/presentation/screen/settings_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // ── Auth flow (unauthenticated) ──────────────
    AutoRoute(page: LoginRoute.page, initial: true),

    // ── Main shell with bottom navigation ────────
    AutoRoute(
      page: ShellRoute.page,
      guards: [AuthGuard()],
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: ExpenseHistoryRoute.page),
        AutoRoute(page: CaptureInvoiceRoute.page),
        AutoRoute(page: AnalyticsRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),

    // ── Feature routes (authenticated) ───────────
    AutoRoute(page: OcrProcessingRoute.page),
    AutoRoute(page: ExtractedDataReviewRoute.page),
    AutoRoute(page: InvoiceDetailRoute.page),
    AutoRoute(page: CameraCaptureRoute.page),
  ];
}
