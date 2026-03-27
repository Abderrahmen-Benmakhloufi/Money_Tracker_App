import 'package:expense_tracker_app/models/income.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expense_item.dart';
import 'package:expense_tracker_app/widgets/expenses_list/income_item.dart';

import '../../models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    required this.onRemoved,
    required this.expenses,
    super.key,
  });
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoved;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: const EdgeInsets.symmetric(horizontal: 16),
        ),
        onDismissed: (direction) => onRemoved(expenses[index]),
        key: ValueKey(expenses[index]),
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}

class IncomeList extends StatelessWidget {
  const IncomeList({required this.income, super.key});
  final List<Income> income;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: income.length,
      itemBuilder: (ctx, index) => IncomeItem(income[index]),
    );
  }
}
