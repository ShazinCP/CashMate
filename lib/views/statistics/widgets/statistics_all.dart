import 'package:cashmate/controller/statistics_provider.dart';
import 'package:cashmate/controller/transactiondb_provider.dart';
import 'package:cashmate/controller/utility_provider.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScreenAll extends StatelessWidget {
  const ScreenAll({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cWhiteARGBColor3,
        body: Consumer2<TransactionDBProvider, UtilityProvider>(
          builder: (context, transactionProvider, utilityProvider, child) {
            Map incomeMap = {
              'name': 'Income',
              "amount": utilityProvider.income(),
            };
            Map expenseMap = {
              "name": "Expense",
              "amount": utilityProvider.expense()
            };
            List<Map> totalMap = [incomeMap, expenseMap];
            return transactionProvider.graphList.isEmpty
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
                    builder: (context, statisticProvider, child) {
                      return SfCircularChart(
                        tooltipBehavior: statisticProvider.tooltipBehavior,
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


// import 'package:cashmate/controller/transactiondb_provider.dart';
// import 'package:cashmate/controller/utility_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';


// class pichartAll extends StatefulWidget {
//    const pichartAll({super.key});

//   @override
//   State<pichartAll> createState() => _pichartAllState();
// }

// class _pichartAllState extends State<pichartAll> {
//   late TooltipBehavior _tooltipBehavior;

//   @override
//   void initState() {
//     _tooltipBehavior=TooltipBehavior(enable: true);
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//      final Size size = MediaQuery.of(context).size;
//     return Consumer<TransactionDBProvider>(
//       builder: (context, value, child) {
//         Map incomeMap={
//           "name":"Income","amount":UtilityProvider().income(),
//         };
//            Map expenseMap={
//           "name":"Expense","amount":UtilityProvider().expense(),
//         };
//         List<Map>totalMap=[incomeMap,expenseMap];

//         return Provider.of<TransactionDBProvider>(context).graphList.isEmpty
//       ? SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             SizedBox(height: size.height*0.2,),
//             Center(child: Image.asset('asset/notdataIcon/notDataIcon-removebg-preview.png'))
//           ],
//         ),
//       )
//       :SfCircularChart(
//         tooltipBehavior:_tooltipBehavior,
//         series: <CircularSeries>[
//           PieSeries<Map,String>(
//             dataSource: totalMap,
//             xValueMapper: (Map data,_)=>data["name"],
//             yValueMapper: (Map data,_)=>data['amount'],
//             dataLabelSettings: const DataLabelSettings(
//               isVisible: true,
//             )
//           )
//         ],
//         legend:  Legend(
//           isVisible: true,
//           overflowMode: LegendItemOverflowMode.scroll,
//           alignment: ChartAlignment.center
//         ),
//       );
//       },
       
//     );
//   }
// }