import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../expenses/model.dart';

class WeeklyExpensesWidget extends StatelessWidget {
  final List<Expenses> expenses;

  const WeeklyExpensesWidget({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    int getWeekNumber(DateTime date){
      final dayOfYear = int.parse(DateFormat("D").format(date));
      return ((dayOfYear - date.weekday + 10) / 7).floor();
    }

    final Map<String, double> weeklyTotals = {};

    for (final e in expenses) {
      if(e.datePaid == null) continue;
      final d = e.datePaid!;
      final weekNumber = getWeekNumber(d);

      final key = "${d.year}-W$weekNumber";
      weeklyTotals[key] = (weeklyTotals[key] ?? 0) + e.amount;

    }

    return ListView(
      children: weeklyTotals.entries.map((entry) {
        return ListTile(
          title: Text(entry.key, style: TextStyle(color: Colors.white)),
          trailing: Text("₱${entry.value.toStringAsFixed(2)}",
              style: TextStyle(color: Colors.white)),
        );
      }).toList(),
    );
  }
}
