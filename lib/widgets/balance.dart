import 'package:expense_tracker_app/models/income.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';

class Balance extends StatefulWidget {
  //final double curruntBalance;
  final List<Expense> expenses;
  final List<Income> Incomes;

  const Balance({super.key, required this.expenses, required this.Incomes});
  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  String _selectedcurrency = currencies[0];
  DropdownButtonHideUnderline currencySelection() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: _selectedcurrency,

        items: currencies
            .map(
              (currency) => DropdownMenuItem(
                value: currency,
                child: Text(currency, style: thestyle(context, 15)),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value == null) {
            return;
          }
          setState(() {
            _selectedcurrency = value;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final moneydata = MyMoney(
      expenses: widget.expenses,
      Incomes: widget.Incomes,
    );
    double curruntBalance = moneydata.totalBalance;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text('Balance', style: thestyle(context, 13)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('$curruntBalance ', style: thestyle(context, 24)),
              const SizedBox(width: 8),
              currencySelection(),
            ],
          ),
        ],
      ),
    );
  }
}

TextStyle thestyle(context, double fontsize) {
  return Theme.of(context).textTheme.titleLarge!.copyWith(
    color: Theme.of(context).colorScheme.onPrimaryContainer,
    fontSize: fontsize,
  );
}
