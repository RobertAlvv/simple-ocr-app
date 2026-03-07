import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../bloc/analytics_bloc.dart';
import '../bloc/analytics_event.dart';
import '../bloc/analytics_state.dart';
import '../widgets/category_expenses_list.dart';
import '../widgets/monthly_bar_chart.dart';
import '../widgets/top_merchants_list.dart';

import '../../../../core/theme/app_spacing.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsView extends StatelessWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<AnalyticsBloc, AnalyticsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (msg) => Center(child: Text('Error: $msg')),
              loaded: (analytics, period) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<AnalyticsBloc>().add(
                      AnalyticsEvent.loadData(period),
                    );
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    children: [
                      // Custom Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Análisis',
                            style: AppTypography.headlineLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _buildPeriodSelector(context, period),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Monthly Summary Card
                      _buildSummaryCard(analytics, period),
                      const SizedBox(height: AppSpacing.lg),

                      // Category Breakdown Section
                      _buildCategorySection(analytics),
                      const SizedBox(height: AppSpacing.lg),

                      // Top Merchants Section
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Principales Proveedores',
                              style: AppTypography.titleLarge,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Ver Todo'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      TopMerchantsList(merchants: analytics.topMerchants),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPeriodSelector(BuildContext context, String selectedPeriod) {
    return PopupMenuButton<String>(
      initialValue: selectedPeriod,
      onSelected: (value) {
        context.read<AnalyticsBloc>().add(AnalyticsEvent.loadData(value));
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'Este Mes', child: Text('Este Mes')),
        const PopupMenuItem(value: 'Mes Anterior', child: Text('Mes Anterior')),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Text(selectedPeriod, style: AppTypography.labelLarge),
            const SizedBox(width: AppSpacing.xs),
            const Icon(Icons.keyboard_arrow_down, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(dynamic analytics, String period) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resumen de Gastos',
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '\$${analytics.monthlyTotal.toStringAsFixed(2)}',
                    style: AppTypography.displayLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.trending_up,
                      size: 14,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '5.2%',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 160,
            child: MonthlyBarChart(data: analytics.barChartData),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(dynamic analytics) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gastos por Categoría',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '\$${analytics.monthlyTotal.toStringAsFixed(2)}',
            style: AppTypography.headlineLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Circular Chart from Syncfusion
          SizedBox(
            height: 180,
            child: SfCircularChart(
              margin: EdgeInsets.zero,
              series: <CircularSeries>[
                DoughnutSeries<dynamic, String>(
                  dataSource: analytics.categoryExpenses,
                  xValueMapper: (dynamic data, _) => data.category,
                  yValueMapper: (dynamic data, _) => data.amount,
                  innerRadius: '70%',
                  explode: true,
                  explodeOffset: '10%',
                  pointColorMapper: (dynamic data, int index) {
                    final colors = [
                      AppColors.primary,
                      const Color(0xFF009688), // Teal from Stitch
                      const Color(0xFF5C6BC0), // Indigo-ish from Stitch
                    ];
                    return colors[index % colors.length];
                  },
                ),
              ],
              annotations: const <CircularChartAnnotation>[
                CircularChartAnnotation(
                  widget: Text(
                    '100%',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          CategoryExpensesList(categories: analytics.categoryExpenses),
        ],
      ),
    );
  }
}
