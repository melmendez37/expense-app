import 'package:expense_app/expenses/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseSummaryCard extends StatefulWidget{
  final String range;

  const ExpenseSummaryCard({
    super.key,
    required this.range,
  });

  @override
  State<ExpenseSummaryCard> createState() => _ExpenseSummaryCardState();
}

class _ExpenseSummaryCardState extends State<ExpenseSummaryCard>{
  double total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTotal();
  }

  Future<void> loadTotal() async {
    final result = await ExpenseService().getTotalExpenses(widget.range);
    setState(() => total = result);
  }

  @override
  Widget build(BuildContext context) {
    String displaySum;
    if (total >= 1000000000){
      displaySum = "${(total/1000000000).toStringAsFixed(1)}b";
    } else if (total >= 1000000){
      displaySum = "${(total/1000000).toStringAsFixed(1)}m";
    } else if (total >= 1000){
      displaySum = "${(total/1000).toStringAsFixed(1)}k";
    } else {
      displaySum = total.toStringAsFixed(0);
    }

    return Text(
      displaySum.toString(),
      style: TextStyle(
        fontSize: 20,
        fontFamily: "DM_Sans",
        fontWeight: FontWeight.bold,
        color: Colors.green
      ),
    );
  }
}