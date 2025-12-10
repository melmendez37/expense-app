import 'package:flutter/material.dart';

import '../../expenses/model.dart';

class TotalExpensesWidget extends StatelessWidget {
  final List<Expenses> expenses;

  const TotalExpensesWidget({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return _analyticsCard(
      title: "Total Expenses",
      value: expenses.length.toString(),
    );
  }

  Widget _analyticsCard({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF5A5A5A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 10),
          Text(value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
