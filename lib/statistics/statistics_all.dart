    import 'package:cashmate/db_functions/income_expence.dart';
import 'package:cashmate/db_functions/transactionDB.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

ValueNotifier<List<MoneyModel>> overViewGraphNotifier =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class ScreenAll extends StatefulWidget {
   const ScreenAll({super.key});

  @override
  State<ScreenAll> createState() => _ScreenAll();
}

class _ScreenAll extends State<ScreenAll> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 245, 245),
        //Color.fromARGB(255, 205, 204, 204),
        body: ValueListenableBuilder(
          valueListenable: overViewGraphNotifier,
          builder: (BuildContext context, List<MoneyModel> newList,
              Widget? child) {
            Map incomeMap = {
              'name': 'Income', "amount":  IncomeAndExpence().income(),
              // income()
              // incomeTotal.value
            };
            Map expenseMap = {
              "name": "Expense", "amount": IncomeAndExpence().expense()
              //expenseTotal.value
            };
            List<Map> totalMap = [incomeMap, expenseMap];
            //List<Map> totalMap = [incomeMap, expenseMap];
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
                : SfCircularChart(
                    tooltipBehavior: _tooltipBehavior,
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
        ),
      ),
    );
  }
}