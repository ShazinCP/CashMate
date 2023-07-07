import 'package:cashmate/db_functions/transactionDB.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


int totals = 0;
final transactionDB = Hive.box<MoneyModel>(transactionDBName);
ValueNotifier expenseTotal = ValueNotifier(0.0);
ValueNotifier incomeTotal = ValueNotifier(0.0);

class IncomeAndExpence {
  int total() {
    var history2 = transactionDB.values.toList();
    List a = [0, 0];
    for (var i = 0; i < history2.length; i++) {
      a.add(history2[i].IN == 'income'
          ? int.parse(history2[i].amount)
          : int.parse(history2[i].amount) * -1);
    }
    totals = a.reduce((value, element) => value + element);
    return totals;
  }

  int income() {
    var history2 = transactionDB.values.toList();
    List a = [0, 0];
    for (var i = 0; i < history2.length; i++) {
      a.add(
          history2[i].IN == 'income' ? int.parse(history2[i].amount) : 0);
    }
    totals = a.reduce((value, element) => value + element);
    return totals;
  }

  int expense() {
    var history2 = transactionDB.values.toList();
    List a = [0, 0];
    for (var i = 0; i < history2.length; i++) {
      a.add(
          history2[i].IN == 'income' ? 0 : int.parse(history2[i]
          .amount));
    }
    totals = a.reduce((value, element) => value + element);
    return totals;
  }
}