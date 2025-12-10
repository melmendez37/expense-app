import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../expenses/model.dart';



class HeatmapPaidWidget extends StatelessWidget {
  final List<Expenses> expenses;

  const HeatmapPaidWidget({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final Map<int, int> frequency = {};

    for (final e in expenses) {
      if (e.datePaid != null) {
        final day = e.datePaid!.day;
        frequency[day] = (frequency[day] ?? 0) + 1;
      }
    }

    return GridView.count(
      crossAxisCount: 7,
      children: List.generate(31, (i) {
        final day = i + 1;
        final count = frequency[day] ?? 0;

        return Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: count == 0
                ? Colors.grey.shade800
                : Colors.green.withOpacity(min(1, count / 5)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              day.toString(),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        );
      }),
    );
  }
}
