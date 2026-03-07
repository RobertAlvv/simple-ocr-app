import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entity/analytics_entity.dart';

class MonthlyBarChart extends StatelessWidget {
  final List<MonthlyExpense> data;

  const MonthlyBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('Sin datos'));
    }

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      margin: EdgeInsets.zero,
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: AppTypography.caption.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      primaryYAxis: NumericAxis(
        isVisible: false,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      series: <CartesianSeries<MonthlyExpense, String>>[
        ColumnSeries<MonthlyExpense, String>(
          dataSource: data,
          xValueMapper: (MonthlyExpense expense, _) => expense.month,
          yValueMapper: (MonthlyExpense expense, _) => expense.amount,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          pointColorMapper: (MonthlyExpense expense, int index) {
            final opacities = [0.3, 0.4, 0.5, 0.6, 0.8, 1.0];
            final opacity = index < opacities.length ? opacities[index] : 1.0;
            return AppColors.primary.withValues(alpha: opacity);
          },
          width: 0.6,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: AppTypography.labelMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
            labelAlignment: ChartDataLabelAlignment.outer,
            builder: (data, point, series, pointIndex, seriesIndex) {
              final amount = (data as MonthlyExpense).amount;
              if (amount >= 1000) {
                return Text(
                  '${(amount / 1000).toStringAsFixed(1)}k',
                  style: AppTypography.caption.copyWith(fontSize: 10),
                );
              }
              return Text(amount.toStringAsFixed(0));
            },
          ),
        ),
      ],
    );
  }
}
