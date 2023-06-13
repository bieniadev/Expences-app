import 'package:flutter/material.dart';

import 'package:better_expenses_app/models/expense_blueprint.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 1),
            Row(children: [
              Text('${expense.amount.toStringAsFixed(2)} zł'),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(width: 8),
                  Text(
                    expense.formattedDate,
                  ),
                ],
              ),
            ])
          ],
        ),
      ),
    );
  }
}
