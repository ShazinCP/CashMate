    import 'package:cashmate/controller/statistics_provider.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/services/income_expence.dart';
import 'package:cashmate/services/transactionDB.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

ValueNotifier<List<MoneyModel>> overViewGraphNotifier =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class ScreenAll extends StatelessWidget {
   const ScreenAll({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cWhiteARGBColor3,
        body: ValueListenableBuilder(
          valueListenable: overViewGraphNotifier,
          builder: (BuildContext context, List<MoneyModel> newList,
              Widget? child) {
            Map incomeMap = {
              'name': 'Income', "amount":  IncomeAndExpence().income(),
            };
            Map expenseMap = {
              "name": "Expense", "amount": IncomeAndExpence().expense()
            };
            List<Map> totalMap = [incomeMap, expenseMap];
            return overViewGraphNotifier.value.isEmpty
                ? const SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(child: Text('No data Found')),
                        ],
                      ),
                    ),
                  )
                : Consumer<StatisticsProvider>(
                  builder: (context, provider, child) {
                    return SfCircularChart(
                      tooltipBehavior: provider.tooltipBehavior,
                      series: <CircularSeries>[
                        PieSeries<Map, String>(
                          dataSource: totalMap,
                          xValueMapper: (Map data, _) => data['name'],
                          yValueMapper: (Map data, _) => data['amount'],
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
                  
                );
          },
        ),
      ),
    );
  }
}