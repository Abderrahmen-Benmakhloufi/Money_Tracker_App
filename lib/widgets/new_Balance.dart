import 'package:expense_tracker_app/models/income.dart';
import 'package:flutter/material.dart';

class NewBalance extends StatefulWidget {
  const NewBalance({required this.onaddIncome, super.key});
  final void Function(Income income) onaddIncome;

  @override
  State<NewBalance> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewBalance> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? selectedDate;

  void _presentdatepicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    var pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void _submitBalanceData() {
    final enteredamount = double.tryParse(_amountcontroller.text);
    final amountisInvalid = enteredamount == null || enteredamount <= 0;

    if (_titlecontroller.text.trim().isEmpty ||
        amountisInvalid ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Invalid title ,amount or date was picked'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onaddIncome(
      Income(
        title: _titlecontroller.text,
        amount: enteredamount,
        date: selectedDate!,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New Operation was added'),
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(8, 24, 8, keyboardspace + 48),
          child: Column(
            children: [
              TextField(
                controller: _titlecontroller,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('title')),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountcontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('amount'),
                        prefixText: '\$ ',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          selectedDate == null
                              ? 'no Date'
                              : formatter.format(selectedDate!),
                        ),
                        IconButton(
                          onPressed: _presentdatepicker,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitBalanceData,
                    child: const Text('save Balance Adding'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
