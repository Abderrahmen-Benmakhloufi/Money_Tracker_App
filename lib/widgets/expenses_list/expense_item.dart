import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title),
            const SizedBox(height: 4),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text('\$${expense.amount.toStringAsFixed(2)}'),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        CategoryIcons[expense.category],
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const Spacer(),
                      Text(expense.formattedDate),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
