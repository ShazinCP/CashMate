import 'package:cashmate/transaction/transactions_screen.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


const transactionDBName = 'Transaction_database';

class TransactionDB extends ChangeNotifier {
  TransactionDB.internal();

  static TransactionDB instance = TransactionDB.internal();

  factory TransactionDB() {
    return instance;
  }
  ValueNotifier<List<MoneyModel>> transactionListNotifier =
      ValueNotifier([]);

  Future<void> getAllTransactions() async {
    final transactionDB =
        await Hive.openBox<MoneyModel>(transactionDBName);
    transactionListNotifier.value.clear();

    transactionListNotifier.value.addAll(transactionDB.values);

    transactionListNotifier.notifyListeners();
  }

  Future<void> insertTransaction(MoneyModel obj) async {
    final transactionDB =
        await Hive.openBox<MoneyModel>(transactionDBName);
    await transactionDB.put(obj.id, obj);
    getAllTransactions();
  }

  Future<void> deleteTransaction(MoneyModel transactionModel) async {
    final transactionDB =
        await Hive.openBox<MoneyModel>(transactionDBName);
    transactionDB.delete(transactionModel.id);
    overViewListNotifier.notifyListeners();
    getAllTransactions();
  }

  Future<void> editTransaction(MoneyModel value) async {
    final transactionDB =
        await Hive.openBox<MoneyModel>(transactionDBName);
    transactionDB.put(value.id, value);
    overViewListNotifier.notifyListeners();
    getAllTransactions();
  }
}