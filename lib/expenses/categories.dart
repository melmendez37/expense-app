import 'package:flutter/material.dart';

enum Categories {
  living(color: Colors.blueAccent,
      title: "Living (Grocery, Rent, Utilities, Clothing)"),
  transport(color: Colors.grey,
      title: "Transportation (Maintenance, Commute, Insurance, Gas)"),
  family(color: Colors.teal,
      title: "Family (Pet Food and Care, School Supplies, etc)"),
  personal(color: Colors.yellow,
      title: "Personal (Hygiene, Grooming, Wellness, Laundry)"),
  health(color: Colors.grey,
      title: "Health (Medicines, Insurance, Dental, Gym)"),
  tech(color: Colors.grey,
      title: "Technology (Smartphone plans, Internet, Streaming, Gaming)"),
  debt(color: Colors.grey,
      title: "Debt (Credit Card, Medical debt, Loans)"),
  savings(color: Colors.grey,
      title: "Save/Invest (Emergency Fund, College Savings, Retirement, etc)"),
  entertain(color: Colors.grey,
      title: "Entertainment (Dining, Movies, Recreational Activities, Vacation)"),
  misc(color: Colors.grey,
      title: "Miscellaneous (Occasional gifts, Professional Dues, etc)");

  const Categories({required this.color, required this.title});

  final Color color;
  final String title;
}