import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'income.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category { travel, food, leisure, work }

const CategoryIcons = {
  Category.food: Icons.food_bank,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.name,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      category: Category.values.byName(map['category']),
    );
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> AllExpense, this.category)
    : expenses = AllExpense.where(
        (expense) => expense.category == category,
      ).toList();

  double get totalExpenses {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}

class MyMoney {
  final List<Expense> expenses;
  final List<Income> Incomes;

  MyMoney({required this.expenses, required this.Incomes});

  double get totalBalance {
    double toalBalanceForNow = 0;
    for (var expense in expenses) {
      toalBalanceForNow -= expense.amount;
    }
    for (var Income in Incomes) {
      toalBalanceForNow += Income.amount;
    }
    return toalBalanceForNow;
  }
}
