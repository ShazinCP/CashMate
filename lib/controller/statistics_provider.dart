import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsProvider extends ChangeNotifier {
  late TooltipBehavior tooltipBehavior;
    String dateFilterTitle = "All";

  void changeValue(String? value){
      dateFilterTitle = value!;
     notifyListeners();

  }

  StatisticsProvider() {
    tooltipBehavior = TooltipBehavior(enable: true);
  }
}
