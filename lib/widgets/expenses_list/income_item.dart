import 'package:expense_tracker_app/models/income.dart';
import 'package:flutter/material.dart';

class IncomeItem extends StatelessWidget {
  const IncomeItem(this.income, {super.key});
  final Income income;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(income.title),
            const SizedBox(height: 4),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text('\$${income.amount.toStringAsFixed(2)}'),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.add, color: Colors.green),
                      const Icon(Icons.monetization_on, color: Colors.green),
                      const Spacer(),
                      Text(income.formattedDate),
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
