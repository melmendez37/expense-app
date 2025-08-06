import 'dart:math';

class Expenses{
  final String id;
  final String title;
  final String type;
  final String? ref;
  final String? category;
  final double? amount;
  final DateTime? dueDate;
  final DateTime? datePaid;
  final String profileId;

  Expenses({
    required this.id,
    required this.title,
    required this.type,
    this.ref,
    this.category,
    this.amount,
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
      category: map['category'] as String?,
      amount: map['amount'] as double?,
      dueDate: map['due_date'] as DateTime?,
      datePaid: map['date_paid'] as DateTime?,
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
      'amount': amount,
      'due_date': dueDate,
      'date_paid': datePaid,
      'user_id': profileId,
    };
  }
}