import 'package:flutter/material.dart';

import '../../expenses/model.dart';

class DailyExpensesWidget extends StatelessWidget {
  final List<Expenses> expenses;

  const DailyExpensesWidget({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> dailyTotals = {};

    for (final e in expenses) {
      final key = "${e.datePaid?.year}-${e.datePaid?.month}-${e.datePaid?.day}";
      if (e.datePaid != null) {
        dailyTotals[key] = (dailyTotals[key] ?? 0) + e.amount;
      }
    }

    return ListView(
      children: dailyTotals.entries.map((entry) {
        return ListTile(
          title: Text(entry.key, style: TextStyle(color: Colors.white)),
          trailing: Text("₱${entry.value.toStringAsFixed(2)}",
              style: TextStyle(color: Colors.white)),
        );
      }).toList(),
    );
  }
}
