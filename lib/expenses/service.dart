import 'package:supabase_flutter/supabase_flutter.dart';

import 'model.dart';

class ExpenseService {
  final database = Supabase.instance.client.from('expenses');

  Future createExpense(Expenses newExpense) async {
    await database.insert(newExpense.toMap());
  }

  final stream = Supabase.instance.client
      .from('expenses')
      .stream(primaryKey: ['expense_id'])
      .eq('user_id', Supabase.instance.client.auth.currentUser!.id)
      .map((data) => data.map((expenseMap) => Expenses.fromMap(expenseMap))
      .toList());

  Future updateExpense(Expenses expense, Expenses newExpenses) async {
    await database.update({
      'title': newExpenses.title,
      'type': newExpenses.type,
      'ref_number': newExpenses.ref,
      'category': newExpenses.category,
      'amount': newExpenses.amount,
      'due_date': newExpenses.dueDate != null ?
        newExpenses.dueDate!.toIso8601String().split('T')[0] : null,
      'date_paid': newExpenses.datePaid != null ?
        newExpenses.datePaid!.toIso8601String().split("T")[0] : null,
      'user_id': expense.profileId,
    }).eq('expense_id', expense.id).select();
  }

  Future<double> getTotalExpenses(String range) async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;

    final now = DateTime.now().toUtc();
    DateTime start;

    switch(range){
      case 'daily':
        start = DateTime.utc(now.year, now.month, now.day);
        break;
      case 'weekly':
        start = now.subtract(Duration(days: now.weekday - 1));
        break;
      case 'monthly':
        start = DateTime.utc(now.year, now.month, 1);
        break;
      default:
        start = DateTime.utc(now.year, now.month, now.day);
    }

    final end = DateTime.utc(now.year, now.month, now.day, 23, 59, 59);

    final data = await supabase
      .from('expenses')
      .select('amount')
      .eq('user_id', userId)
      .gte('created_at', start.toIso8601String())
      .lte('created_at', end.toIso8601String());

    double total = 0;
    for(final row in data){
      total += (row['amount'] as num).toDouble();
    }

    return total;
  }

  }