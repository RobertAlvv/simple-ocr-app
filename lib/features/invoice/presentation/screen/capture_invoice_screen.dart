import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../view/capture_invoice_view.dart';

@RoutePage()
class CaptureInvoiceScreen extends StatelessWidget {
  const CaptureInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CaptureInvoiceView();
  }
}
