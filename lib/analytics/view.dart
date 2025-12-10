import 'package:expense_app/expenses/service.dart';
import 'package:flutter/material.dart';

import '../expenses/model.dart';
import 'metrics/categories.dart';
import 'metrics/daily_expenses.dart';
import 'metrics/date_paid.dart';
import 'metrics/due_date.dart';
import 'metrics/monthly_expenses.dart';
import 'metrics/total_number.dart';
import 'metrics/weekly_expenses.dart';

class AnalyticsView extends StatefulWidget{
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  String selectedMetric = "Category of expenses";
  final expenseService = ExpenseService();

  final List<String> metrics = [
    "Category of expenses",
    "Total number of expenses",
    "Daily expenses",
    "Weekly expenses",
    "Monthly expenses",
    "Due payments",
    "Paid expenses",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        title: Text(
          'Analytics',
          style: TextStyle(
              color: Color(0xFFD9D9D9),
              fontFamily: "DM_Sans",
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        leading: BackButton(
          onPressed: () async {
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
        iconTheme: IconThemeData(
            color: Color(0xFFD9D9D9)
        ),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Color(0xFF0b101c),


      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xFF050610),
                borderRadius: BorderRadius.circular(12),
              ),
              child: (
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedMetric,
                      dropdownColor: const Color(0xFF050610),
                      iconEnabledColor: Colors.white,
                      onChanged: (value) {
                        setState(() => selectedMetric = value!);
                      },
                      items: metrics.map((metric) {
                        return DropdownMenuItem(
                          value: metric,
                          child: Text(
                            metric,
                            style: const TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontFamily: "DM_Sans",
                              fontSize: 18,
                            ),
                          ),
                        );
                      }).toList(),

                    ),
                  )
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20
              ),
              child: _buildMetricWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricWidget() {
    return StreamBuilder<List<Expenses>>(
      stream: expenseService.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final expenses = snapshot.data!;

        switch (selectedMetric) {
          case "Category of expenses":
            return CategoryPieChart(expenses: expenses, );

          case "Total number of expenses":
            return TotalExpensesWidget(expenses: expenses);

          case "Daily expenses":
            return DailyExpensesWidget(expenses: expenses);

          case "Weekly expenses":
            return WeeklyExpensesWidget(expenses: expenses);

          case "Monthly expenses":
            return MonthlyExpensesWidget(expenses: expenses);

          case "Due payments":
            return HeatmapDueWidget(expenses: expenses);

          case "Paid expenses":
            return HeatmapPaidWidget(expenses: expenses);
        }

        return const SizedBox();
      },
    );
  }
}

