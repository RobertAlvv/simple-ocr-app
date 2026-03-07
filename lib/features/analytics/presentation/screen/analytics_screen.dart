import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/analytics_bloc.dart';
import '../bloc/analytics_event.dart';
import '../view/analytics_view.dart';

@RoutePage()
class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<AnalyticsBloc>()..add(const AnalyticsEvent.loadData()),
      child: const AnalyticsView(),
    );
  }
}
