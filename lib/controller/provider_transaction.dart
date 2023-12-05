import 'package:flutter/material.dart';

class ProviderTransaction extends ChangeNotifier {
TextEditingController limitController = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var limit;

  // ignore: prefer_typing_uninitialized_variables
  var expense1;

  TextEditingController searchQueryController = TextEditingController();

  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];

  DateTime date = DateTime.now();

  String? selectedType;

  final formKey = GlobalKey<FormState>();

  final TextEditingController explainController = TextEditingController();

  String? selectedItem;

  FocusNode ex = FocusNode();

  final TextEditingController amountcontroller = TextEditingController();

  FocusNode amount = FocusNode();

  final List<String> iteminex = ['income', 'expense'];

  final List<String> item = [
    'food',
    "Hospital",
    "Transportation",
    "Education",
    "Clothing",
    "Other"
  ];

  void setDate(DateTime? newDate) {
    if (newDate != null) {
      date = newDate;
      notifyListeners();
    }
  }

  void setSelectedType(String value) {
    selectedType = value;
    notifyListeners();
  }

  void setSelectedItem(String value) {
    selectedItem = value;
    notifyListeners();
  }
}
