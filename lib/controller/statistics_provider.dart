import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsProvider extends ChangeNotifier {
  late TooltipBehavior tooltipBehavior;

  StatisticsProvider() {
    tooltipBehavior = TooltipBehavior(enable: true);
  }
}
