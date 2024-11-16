import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widget/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemove;
  const ExpensesList({super.key, required this.expenses, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),
              key: ValueKey(expenses[index]),
              onDismissed: (direction){
                onRemove(expenses[index]);

              },
              child: ExpenseItem(expenses[index]));
        });
  }
}
