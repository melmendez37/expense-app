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
  }