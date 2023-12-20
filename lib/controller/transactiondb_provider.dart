import 'package:cashmate/model/data_model.dart';
import 'package:cashmate/services/db_services.dart';
import 'package:flutter/material.dart';

const transactionDBName = 'Transaction_database';

class TransactionDBProvider extends ChangeNotifier {
  // TransactionDBProvider(){
  //   setAllList();
  // }

  List<MoneyModel> transactionList = [];
  List<MoneyModel> graphList = [];

  ValueNotifier showCategory = ValueNotifier('All');

  final TransactionService _transactionService = TransactionService();

  Future<void> getAllTransactions() async {
    transactionList = await _transactionService.getAllTransactions();
    notifyListeners();
  }

  Future<void> insertTransaction(MoneyModel obj) async {
    await _transactionService.insertTransaction(obj);
    await getAllTransactions();
  }

  Future<void> deleteTransaction(MoneyModel transactionModel) async {
    await _transactionService.deleteTransaction(transactionModel.id);
    await getAllTransactions();
  }

  Future<void> editTransaction(MoneyModel value) async {
    await _transactionService.editTransaction(value);
    notifyListeners();
    await getAllTransactions();
  }

  void setAllList() {
    graphList = transactionList;
    notifyListeners();
  }
}
