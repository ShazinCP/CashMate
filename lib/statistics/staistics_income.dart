import 'package:cashmate/model/data_model.dart';
import 'package:cashmate/statistics/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScreenIncomeChart extends StatelessWidget {
  const ScreenIncomeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 245, 245),
        body: ValueListenableBuilder(
          valueListenable: overViewGraphNotifier,
          builder: (BuildContext context, List<MoneyModel> newList,
              Widget? child) {
            var allIncome = newList
                .where((element) => element.IN == 'income')
                .toList();
            return overViewGraphNotifier.value.isEmpty
                ? SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Center(child: Text('No data Found')),
                        ],
                      ),
                    ),
                  )
                : SfCircularChart(
                    series: <CircularSeries>[
                      PieSeries<MoneyModel, String>(
                        dataSource: allIncome,
                        xValueMapper: (MoneyModel incomeDate, _) =>
                            incomeDate.name,
                        yValueMapper: (MoneyModel incomeDate, _) =>
                            int.parse(incomeDate.amount),
                        //num.parse(incomeDate.amount),
                        //incomeDate.hashCode,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                      )
                    ],
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.scroll,
                      alignment: ChartAlignment.center,
                    ),
                  );
          },
        ),
      ),
    );
  }
}