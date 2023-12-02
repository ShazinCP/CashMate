import 'package:cashmate/model/data_model.dart';
import 'package:hive/hive.dart';

int totals = 0;

final box = Hive.box<MoneyModel>('data');

List<MoneyModel> today() {
  List<MoneyModel> a = [];
  var history2 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].datetime.day == date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<MoneyModel> week() {
  List<MoneyModel> a = [];
  DateTime date = DateTime.now();
  var history2 = box.values.toList();
  for (var i = 0; i < history2.length; i++) {
    if (date.day - 7 <= history2[i].datetime.day &&
        history2[i].datetime.day <= date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<MoneyModel> month() {
  List<MoneyModel> a = [];
  var history2 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].datetime.month == date.month) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<MoneyModel> year() {
  List<MoneyModel> a = [];
  var history2 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].datetime.year == date.year) {
      a.add(history2[i]);
    }
  }
  return a;
}

int total_chart(List<MoneyModel> history2) {
  List a = [0, 0];

  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].type == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

List time(List<MoneyModel> history2, bool hour) {
  List<MoneyModel> a = [];
  List total = [];
  int counter = 0;
  for (var c = 0; c < history2.length; c++) {
    for (var i = c; i < history2.length; i++) {
      if (hour) {
        if (history2[i].datetime.hour == history2[c].datetime.hour) {
          a.add(history2[i]);
          counter = i;
        }
      } else {
        if (history2[i].datetime.day == history2[c].datetime.day) {
          a.add(history2[i]);
          counter = i;
        }
      }
    }
    total.add(total_chart(a));
    a.clear();
    c = counter;
  }
  print(total);
  return total;
}
