import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

class Income {
  Income({required this.title, required this.amount, required this.date})
    : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;

  String get formattedDate {
    return formatter.format(date);
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'amount': amount, 'date': date.toIso8601String()};
  }

  // استرجاع الدخل من Map
  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
    );
  }
}

List<String> currencies = ['USD', 'DZD', 'EUR'];
