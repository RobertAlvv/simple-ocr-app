// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AnalyticsScreen]
class AnalyticsRoute extends PageRouteInfo<void> {
  const AnalyticsRoute({List<PageRouteInfo>? children})
    : super(AnalyticsRoute.name, initialChildren: children);

  static const String name = 'AnalyticsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AnalyticsScreen();
    },
  );
}

/// generated route for
/// [CameraCaptureScreen]
class CameraCaptureRoute extends PageRouteInfo<void> {
  const CameraCaptureRoute({List<PageRouteInfo>? children})
    : super(CameraCaptureRoute.name, initialChildren: children);

  static const String name = 'CameraCaptureRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CameraCaptureScreen();
    },
  );
}

/// generated route for
/// [CaptureInvoiceScreen]
class CaptureInvoiceRoute extends PageRouteInfo<void> {
  const CaptureInvoiceRoute({List<PageRouteInfo>? children})
    : super(CaptureInvoiceRoute.name, initialChildren: children);

  static const String name = 'CaptureInvoiceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CaptureInvoiceScreen();
    },
  );
}

/// generated route for
/// [ExpenseHistoryScreen]
class ExpenseHistoryRoute extends PageRouteInfo<void> {
  const ExpenseHistoryRoute({List<PageRouteInfo>? children})
    : super(ExpenseHistoryRoute.name, initialChildren: children);

  static const String name = 'ExpenseHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ExpenseHistoryScreen();
    },
  );
}

/// generated route for
/// [ExtractedDataReviewScreen]
class ExtractedDataReviewRoute
    extends PageRouteInfo<ExtractedDataReviewRouteArgs> {
  ExtractedDataReviewRoute({
    Key? key,
    required String invoiceId,
    List<PageRouteInfo>? children,
  }) : super(
         ExtractedDataReviewRoute.name,
         args: ExtractedDataReviewRouteArgs(key: key, invoiceId: invoiceId),
         initialChildren: children,
       );

  static const String name = 'ExtractedDataReviewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExtractedDataReviewRouteArgs>();
      return ExtractedDataReviewScreen(
        key: args.key,
        invoiceId: args.invoiceId,
      );
    },
  );
}

class ExtractedDataReviewRouteArgs {
  const ExtractedDataReviewRouteArgs({this.key, required this.invoiceId});

  final Key? key;

  final String invoiceId;

  @override
  String toString() {
    return 'ExtractedDataReviewRouteArgs{key: $key, invoiceId: $invoiceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ExtractedDataReviewRouteArgs) return false;
    return key == other.key && invoiceId == other.invoiceId;
  }

  @override
  int get hashCode => key.hashCode ^ invoiceId.hashCode;
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [InvoiceDetailScreen]
class InvoiceDetailRoute extends PageRouteInfo<InvoiceDetailRouteArgs> {
  InvoiceDetailRoute({
    Key? key,
    required String invoiceId,
    List<PageRouteInfo>? children,
  }) : super(
         InvoiceDetailRoute.name,
         args: InvoiceDetailRouteArgs(key: key, invoiceId: invoiceId),
         rawPathParams: {'id': invoiceId},
         initialChildren: children,
       );

  static const String name = 'InvoiceDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<InvoiceDetailRouteArgs>(
        orElse: () =>
            InvoiceDetailRouteArgs(invoiceId: pathParams.getString('id')),
      );
      return InvoiceDetailScreen(key: args.key, invoiceId: args.invoiceId);
    },
  );
}

class InvoiceDetailRouteArgs {
  const InvoiceDetailRouteArgs({this.key, required this.invoiceId});

  final Key? key;

  final String invoiceId;

  @override
  String toString() {
    return 'InvoiceDetailRouteArgs{key: $key, invoiceId: $invoiceId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! InvoiceDetailRouteArgs) return false;
    return key == other.key && invoiceId == other.invoiceId;
  }

  @override
  int get hashCode => key.hashCode ^ invoiceId.hashCode;
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [OcrProcessingScreen]
class OcrProcessingRoute extends PageRouteInfo<OcrProcessingRouteArgs> {
  OcrProcessingRoute({
    Key? key,
    required String imagePath,
    List<PageRouteInfo>? children,
  }) : super(
         OcrProcessingRoute.name,
         args: OcrProcessingRouteArgs(key: key, imagePath: imagePath),
         initialChildren: children,
       );

  static const String name = 'OcrProcessingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OcrProcessingRouteArgs>();
      return OcrProcessingScreen(key: args.key, imagePath: args.imagePath);
    },
  );
}

class OcrProcessingRouteArgs {
  const OcrProcessingRouteArgs({this.key, required this.imagePath});

  final Key? key;

  final String imagePath;

  @override
  String toString() {
    return 'OcrProcessingRouteArgs{key: $key, imagePath: $imagePath}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OcrProcessingRouteArgs) return false;
    return key == other.key && imagePath == other.imagePath;
  }

  @override
  int get hashCode => key.hashCode ^ imagePath.hashCode;
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}

/// generated route for
/// [ShellScreen]
class ShellRoute extends PageRouteInfo<void> {
  const ShellRoute({List<PageRouteInfo>? children})
    : super(ShellRoute.name, initialChildren: children);

  static const String name = 'ShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ShellScreen();
    },
  );
}
