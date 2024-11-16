import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widget/chart/chart.dart';
import 'package:expense_tracker/widget/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure),
  ];
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense is successfully added'),
      ),
    );
  }

  void _openAddExpenseOverly() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
   

    Widget mainContent = const Center(
      child: Text('No Expense found'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent =
          ExpensesList(expenses: _registeredExpenses, onRemove: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: () {
                _openAddExpenseOverly();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: width <600 ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
        ],
      ): Row(
        children: [
          Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(child: mainContent),
        ],
        
      ),
    );
  }
}
