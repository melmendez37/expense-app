import 'dart:math';

class Expenses{
  final String id;
  final String title;
  final String type;
  final String? ref;
  final String category;
  final double amount;
  final DateTime? dueDate;
  final DateTime? datePaid;
  final String profileId;

  Expenses({
    required this.id,
    required this.title,
    required this.type,
    this.ref,
    required this.category,
    required this.amount,
    this.dueDate,
    this.datePaid,
    required this.profileId,
  });

  factory Expenses.fromMap(Map<String, dynamic> map){
    return Expenses(
      id: map['expense_id'] as String,
      title: map['title'] as String,
      type: map['type'] as String,
      ref: map['ref_number'] as String?,
      category: map['category'] as String,
      amount: (map['amount'] as num).toDouble(),
      dueDate: map['due_date'] != null ? DateTime.parse(map['due_date']) : null,
      datePaid: map['date_paid'] != null ? DateTime.parse(map['date_paid']) : null,
      profileId: map['user_id'] as String,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'expense_id': id,
      'title': title,
      'type': type,
      'ref_number': ref,
      'category': category,
      'amount': amount.toDouble(),
      'due_date': dueDate?.toIso8601String(),
      'date_paid': datePaid?.toIso8601String(),
      'user_id': profileId,
    };
  }
}