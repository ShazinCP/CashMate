import 'package:cashmate/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


const transactionDBName = 'Transaction_database';

class TransactionDBProvider extends ChangeNotifier {

  // TransactionDBProvider(){
  //   setAllList();
  // }

  List<MoneyModel> transactionList = [];
  List<MoneyModel>  graphList = [];

  ValueNotifier showCategory = ValueNotifier('All');

  Future<void> getAllTransactions() async {
    final transactionDB =
        await Hive.openBox<MoneyModel>(transactionDBName);
    transactionList.clear();

    transactionList.addAll(transactionDB.values);

    notifyListeners();
  }

  Future<void> insertTransaction(MoneyModel obj) async {
    final transactionDB =
        await Hive.openBox<MoneyModel>(transactionDBName);
    await transactionDB.put(obj.id, obj);
    getAllTransactions();
    notifyListeners();
  }

  Future<void> deleteTransaction(MoneyModel transactionModel) async {
    final transactionDB =
        await Hive.openBox<MoneyModel>(transactionDBName);
    transactionDB.delete(transactionModel.id);
    getAllTransactions();
    notifyListeners();
  }

  Future<void> editTransaction(MoneyModel value) async {
    final transactionDB =
        await Hive.openBox<MoneyModel>(transactionDBName);
    transactionDB.put(value.id, value);
    getAllTransactions();
    notifyListeners();
  }

  void setAllList(){
   graphList = transactionList;
    notifyListeners();
  }

   void updateSearchList(String enteredText) {
    if (enteredText.isEmpty) {
      results = allsongs;
    } else {
      results = allsongs
          .where(
            (element) => element.explain
                .toLowerCase()
                .trim()
                .contains(enteredText.toLowerCase().trim()),
          )
          .toList();
    }
        // log(results.toString());
    searchSongs = results;
    notifyListeners();

    
  }
}