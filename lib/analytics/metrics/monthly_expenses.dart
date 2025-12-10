import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../expenses/model.dart';

class MonthlyExpensesWidget extends StatelessWidget {
  final List<Expenses> expenses;

  const MonthlyExpensesWidget({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    //int month.number = date.month;
    //Months always start on Jan
    //Month 12 is the month containing Dec10
    //How many full months have passed since the year;s first ISO month
    //day of year 344
    //

    final Map<String, double> monthlyTotals = {};

    for (final e in expenses) {
      if(e.datePaid == null) continue;
      final d = e.datePaid!;

      final key = "${d.year}-${d.month.toString()}";
      monthlyTotals[key] = (monthlyTotals[key] ?? 0) + e.amount;

    }

    return ListView(
      children: monthlyTotals.entries.map((entry) {
        return ListTile(
          title: Text(entry.key, style: TextStyle(color: Colors.white)),
          trailing: Text("₱${entry.value.toStringAsFixed(2)}",
              style: TextStyle(color: Colors.white)),
        );
      }).toList(),
    );
  }
}
