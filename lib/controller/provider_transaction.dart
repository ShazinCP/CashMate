import 'package:cashmate/controller/transactiondb_provider.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  DateTime? selectedEditDateTime;

  // String? selectedEditType;

  // String? selectedEditCategory;

  TextEditingController amountTextEditingController = TextEditingController();

  TextEditingController explainTextEditingController = TextEditingController();

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

  searchResult(BuildContext context, String query) {
    final dbProvider =
        Provider.of<TransactionDBProvider>(context, listen: false);

    debugPrint('queryprinted  $query');
    if (query.isEmpty || query == '') {
      debugPrint(query);

      dbProvider.transactionList = dbProvider.graphList;
    } else {
      dbProvider.transactionList = dbProvider.graphList
          .where((element) =>
              element.name.toLowerCase().contains(query.trim().toLowerCase()) ||
              element.explain.contains(query.trim().toLowerCase()))
          .toList();
    }
  }

  List<MoneyModel> taskModelList = <MoneyModel>[];

  List queryResultList = [];
  String queryval = '';
  addToQueryList(String query) async {
    queryResultList.clear();

    if (query.isEmpty || query == '') {
      queryResultList.clear();
    } else {
      for (var element in taskModelList) {
        if (element.explain
            .trim()
            .toLowerCase()
            .contains(query.trim().toLowerCase())) {
          queryResultList.add(element.explain);
        }
      }
    }
    notifyListeners();
  }
}
