import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../expenses/model.dart';

class CategoryPieChart extends StatelessWidget {
  final List<Expenses> expenses;

  const CategoryPieChart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    // Sum amounts per category
    final Map<String, double> categoryTotals = {};
    for (var e in expenses) {
      final category = e.category ?? 'Other';
      categoryTotals[category] = (categoryTotals[category] ?? 0) + e.amount;
    }

    // Define colors
    final colors = [
      Colors.yellow,
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
    ];

    final pieSections = categoryTotals.entries.map((entry) {
      final index = categoryTotals.keys.toList().indexOf(entry.key);
      return PieChartSectionData(
        value: entry.value,
        color: colors[index % colors.length],
        radius: 100,
        title: '',
      );
    }).toList();

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: PieChart(
            PieChartData(
              sections: pieSections,
              sectionsSpace: 2,
              centerSpaceRadius: 40,
            ),
          ),
        ),
        SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categoryTotals.entries.map((entry) {
            final index = categoryTotals.keys.toList().indexOf(entry.key);
            final color = colors[index % colors.length];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    color: color,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${entry.key}: P${formatAmount(entry.value)}",

                    style: TextStyle(
                      color: Color(0xFFF2F2F2),
                      fontSize: 16,
                      fontFamily: "DM_Sans",
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

String formatAmount(double value) {
  if (value >= 1e9) {
    // Billion
    return "${(value / 1e9).toStringAsFixed(1)}B";
  } else if (value >= 1e6) {
    // Million
    return "${(value / 1e6).toStringAsFixed(1)}M";
  } else if (value >= 1e3) {
    // Thousand
    return "${(value / 1e3).toStringAsFixed(1)}K";
  } else {
    return value.toStringAsFixed(0);
  }
}
