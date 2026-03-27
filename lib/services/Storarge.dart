import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/expense.dart';
import 'package:expense_tracker_app/models/income.dart';

class StorageService {
  static const _key = 'saved_expenses';
  static const _incomeKey = 'saved_incomes';

  static Future<void> saveExpenses(List<Expense> expenses) async {
    final prefs = await SharedPreferences.getInstance();
    // تحويل القائمة إلى نص JSON
    final String encodedData = json.encode(
      expenses.map((e) => e.toMap()).toList(),
    );
    await prefs.setString(_key, encodedData);
  }

  static Future<List<Expense>> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString(_key);

    if (savedData == null) return [];

    final List<dynamic> decodedData = json.decode(savedData);
    return decodedData.map((item) => Expense.fromMap(item)).toList();
  }

  static Future<void> saveIncomes(List<Income> incomes) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      incomes.map((i) => i.toMap()).toList(),
    );
    await prefs.setString(_incomeKey, encodedData);
  }

  static Future<List<Income>> loadIncomes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString(_incomeKey);
    if (savedData == null) return [];
    final List<dynamic> decodedData = json.decode(savedData);
    return decodedData.map((item) => Income.fromMap(item)).toList();
  }
}
