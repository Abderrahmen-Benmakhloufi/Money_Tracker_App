import 'package:expense_tracker_app/models/income.dart';
import 'package:expense_tracker_app/widgets/balance.dart';
import 'package:expense_tracker_app/widgets/new_Balance.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'expenses_list/expenses_list.dart';
import 'chart.dart';
import 'package:expense_tracker_app/services/Storarge.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredexpenses = [];
  final List<Income> _registerdIncomes = [];

  void _addingNewExpense(Expense expense) {
    setState(() {
      _registeredexpenses.add(expense);
    });
    StorageService.saveExpenses(_registeredexpenses);
  }

  void _addingNewIncome(Income income) {
    setState(() {
      _registerdIncomes.add(income);
    });
    StorageService.saveIncomes(_registerdIncomes);
  }

  void _reomveExpense(Expense expense) {
    var indexofExpense = _registeredexpenses.indexOf(expense);
    setState(() {
      _registeredexpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('you just deleted an Expense'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _registeredexpenses.insert(indexofExpense, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddBalanceOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewBalance(onaddIncome: _addingNewIncome),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(onaddExpense: _addingNewExpense),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final savedExpenses = await StorageService.loadExpenses();
    final savedIncomes = await StorageService.loadIncomes();
    setState(() {
      _registeredexpenses.addAll(savedExpenses);
      _registerdIncomes.addAll(savedIncomes);
    });
  }

  void clearAll() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text(
          'You are about to Clear all the data \n Are you sure ?',
        ),
        elevation: 2,
        actionsAlignment: MainAxisAlignment.start,
        title: const Text('ِClear All data'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _registeredexpenses.clear();
                    _registerdIncomes.clear();
                  });
                  Navigator.pop(ctx);
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainText = const Center(
      child: Text('There is no Expenses for now!'),
    );
    Widget mainText2 = const Text('Add some initial Balance! to Start with');
    if (_registeredexpenses.isNotEmpty) {
      mainText = ExpensesList(
        expenses: _registeredexpenses,
        onRemoved: _reomveExpense,
      );
    }
    if (_registerdIncomes.isNotEmpty) {
      mainText2 = IncomeList(income: _registerdIncomes);
    }

    Widget buttonsRow = Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: actionButton(
                const Icon(Icons.arrow_upward),
                _openAddBalanceOverlay,
                const Text('Add Balance'),
                Theme.of(context).colorScheme.primary,
                Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: actionButton(
                const Icon(Icons.arrow_downward),
                _openAddExpenseOverlay,
                const Text('Add Expenses'),
                Theme.of(context).colorScheme.error,
                Colors.white,
              ),
            ),
          ],
        ),
      ],
    );

    Widget balanceWidget = Balance(
      expenses: _registeredexpenses,
      Incomes: _registerdIncomes,
    );

    Widget chartWidget = Chart(expenses: _registeredexpenses);

    Widget listsWidget = Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            mainText2,
            Divider(
              radius: BorderRadius.circular(50),
              indent: 23,
              endIndent: 23,
              thickness: 4,
            ),
            mainText,
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(' Expenses Tracker'),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: clearAll,
                icon: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ],
      ),
      body: MediaQuery.of(context).size.width < 600
          ? Column(
              children: [buttonsRow, balanceWidget, chartWidget, listsWidget],
            )
          : Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [buttonsRow, balanceWidget, chartWidget],
                    ),
                  ),
                ),
                listsWidget,
              ],
            ),
    );
  }

  //The Buttons

  ElevatedButton actionButton(
    Icon icons,
    void Function() action,
    Text label,
    Color color,
    Color stylecolor,
  ) {
    return ElevatedButton.icon(
      icon: icons,
      label: label,

      onPressed: action,
      style: ElevatedButton.styleFrom(
        foregroundColor: stylecolor,
        backgroundColor: color,
        elevation: 10, // Shadow size
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Custom
        ),
      ),
    );
  }
}
