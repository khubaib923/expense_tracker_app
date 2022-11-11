import 'package:expense_tracker/database/entry_save.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier {
  late Future<List<Map<String, dynamic>>> _expenseList;
  late List<Map<String, dynamic>> _map;
  num _incomeSum = 0;
  num _expenseSum = 0;
  num _incomeSave = 0;
  num _expenseSave = 0;
  num _saving = 0;
  num get incomeSave => _incomeSave;
  num get expenseSave => _expenseSave;
  num get saving => _saving;
  Future<List<Map<String, dynamic>>> get expenseList => _expenseList;

  Future<List<Map<String, dynamic>>> getData() {
    _expenseList = DatabaseHelper.instance.queryAll();
    return _expenseList;
  }

  void mapType() async {
    _map = await getData();
    for (int i = 0; i < _map.length; i++) {
      _map[i]["expenseField"] == "Income" ?
      _incomeSum += int.parse(_map[i]["amount"]) : _incomeSum += 0;
      _map[i]["expenseField"] == "Expense" ?
      _expenseSum += int.parse(_map[i]["amount"]) : _expenseSum += 0;
    }
    _incomeSave = _incomeSum;
    _expenseSave = _expenseSum;
    _saving = _incomeSum - _expenseSum;
    _expenseSum = 0;
    _incomeSum = 0;
    notifyListeners();
  }

}