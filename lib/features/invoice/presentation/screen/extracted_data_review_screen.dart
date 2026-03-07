import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/invoice_bloc.dart';
import '../view/extracted_data_review_view.dart';

@RoutePage()
class ExtractedDataReviewScreen extends StatelessWidget {
  final String invoiceId;

  const ExtractedDataReviewScreen({super.key, required this.invoiceId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<InvoiceBloc>()..add(InvoiceEvent.getInvoiceDetail(invoiceId)),
      child: const ExtractedDataReviewView(),
    );
  }
}
