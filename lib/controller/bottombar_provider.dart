import 'package:cashmate/views/home/home_screen.dart';
import 'package:cashmate/views/settings/settings_screen.dart';
import 'package:cashmate/views/statistics/statistics_screen.dart';
import 'package:cashmate/views/transaction/transaction_list.dart';
import 'package:flutter/material.dart';

class BottomProvider extends ChangeNotifier {
  final List tabs = [
    const HomeScreen(),
    const TransactionList(),
    const StatisticsScreen(),
    const Settings()
  ];

  int currentIndex = 0;


  void indexColors(int newIndexColor) {
    currentIndex = newIndexColor;
    notifyListeners();
  }
}