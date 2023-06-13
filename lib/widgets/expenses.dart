import 'package:flutter/material.dart';

import 'package:better_expenses_app/models/expense_blueprint.dart';
import 'chart/chart.dart';
import 'expenses_list/expenses_list.dart';
import 'new_expense.dart';
// import 'widgets';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Kurs flutter',
      amount: 49.99,
      date: DateTime.now(),
      category: Category.praca,
    ),
    Expense(
      title: 'Kino',
      amount: 15.99,
      date: DateTime.now(),
      category: Category.rozrywka,
    )
  ];

  void _openAddExoenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Usunięto wydatek.'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Cofnij',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text('Brak Wydatków. Zacznij dodawać nowe!'));
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(onRemoveExpense: _removeExpense, expenses: _registeredExpenses);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Better Expense Tracker'),
        actions: [IconButton(onPressed: _openAddExoenseOverlay, icon: const Icon(Icons.add))],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
