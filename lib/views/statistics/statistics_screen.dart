import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cashmate/controller/statistics_provider.dart';
import 'package:cashmate/controller/transactiondb_provider.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/views/statistics/widgets/staistics_income.dart';
import 'package:cashmate/views/statistics/widgets/statistics_all.dart';
import 'package:cashmate/views/statistics/widgets/statistics_expences.dart';
import 'package:cashmate/widgets/date_filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _TransactionInsightsAllState();
}

class _TransactionInsightsAllState extends State<StatisticsScreen> {

  @override
  void initState() {
    super.initState();
    final transactionProvider =
        Provider.of<TransactionDBProvider>(context, listen: false);
    transactionProvider.setAllList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteARGBColor3,
      appBar: AppBar(
        backgroundColor: cAppThemeColor,
        title: const Text(
          "Statistics",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Consumer2<TransactionDBProvider, StatisticsProvider>(
        builder: (context, dbProvider, statisticProvider, child) {
          return Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Date  ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DateFilterStatistics(),
                  ],
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: ButtonsTabBar(
                          backgroundColor: cAmberColor,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 40),
                          tabs: const [
                            Tab(
                              iconMargin: EdgeInsets.all(30),
                              text: 'All',
                            ),
                            Tab(
                              text: 'Income',
                            ),
                            Tab(
                              text: 'Expense',
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            ScreenAll(),
                            ScreenIncomeChart(),
                            ScreenExpenseChart(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


// import 'package:buttons_tabbar/buttons_tabbar.dart';
// import 'package:cashmate/controller/statistics_provider.dart';
// import 'package:cashmate/controller/transactiondb_provider.dart';
// import 'package:cashmate/helper/colors.dart';
// import 'package:cashmate/views/statistics/staistics_income.dart';
// import 'package:cashmate/views/statistics/statistics_all.dart';
// import 'package:cashmate/views/statistics/statistics_expences.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class StatisticsScreen extends StatefulWidget {
//   const StatisticsScreen({super.key});

//   @override
//   State<StatisticsScreen> createState() => _StatisticsScreenState();
// }

// class _StatisticsScreenState extends State<StatisticsScreen> {

//   @override
//   void initState() {
//     super.initState();
//     final transactionProvider = Provider.of<TransactionDBProvider>(context, listen: false);
//     transactionProvider.graphList =
//        transactionProvider.transactionList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return SafeArea(
//         child: Scaffold(
//      appBar: AppBar(
//         backgroundColor: cAppThemeColor,
//         title: const Text(
//           "Statistics",
//           style: TextStyle(fontSize: 25),
//         ),
//         centerTitle: true,
//       ),
//      body: Column(
//         children: [
//           const SizedBox(
//             height: 30,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               children: [
//                 const Text(
//                   'Date  ',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Consumer<StatisticsProvider>(
//                   builder: (context, value, child) {
//                     return PopupMenuButton<int>(
//                       shape: ContinuousRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                           70,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                           right: 15.0,
//                         ),
//                         child: Row(
//                           children: [
//                             Text(
//                               value.dateFilterTitle,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const Icon(
//                               Icons.arrow_drop_down,
//                               size: 30,
//                             ),
//                           ],
//                         ),
//                       ),
//                       itemBuilder: (context) => [
//                         PopupMenuItem(
//                           value: 1,
//                           child: const Text(
//                             "All",
//                           ),
//                           onTap: () {
//                             Provider.of<TransactionDBProvider>(context,
//                                     listen: false)
//                                 .graphList = Provider.of<TransactionDBProvider>(
//                                     context,
//                                     listen: false)
//                                 .transactionList;
//                             value.dateFilterTitle = "All";
//                             Provider.of<StatisticsProvider>(context,
//                                     listen: false)
//                                 .changeValue(value.dateFilterTitle);
//                           },
//                         ),
//                         PopupMenuItem(
//                           value: 2,
//                           child: const Text(
//                             "Today",
//                           ),
//                           onTap: () {
//                             Provider.of<TransactionDBProvider>(context,
//                                     listen: false)
//                                 .graphList = Provider.of<TransactionDBProvider>(
//                                     context,
//                                     listen: false)
//                                 .transactionList
//                                 .where(
//                                   (element) =>
//                                       element.datetime.day ==
//                                           DateTime.now().day &&
//                                       element.datetime.year ==
//                                           DateTime.now().year,
//                                 )
//                                 .toList();

//                             value.dateFilterTitle = "Today";
//                             Provider.of<StatisticsProvider>(context,
//                                     listen: false)
//                                 .changeValue(value.dateFilterTitle);
//                           },
//                         ),
//                         PopupMenuItem(
//                           value: 2,
//                           child: const Text(
//                             "Yesterday",
//                           ),
//                           onTap: () {
//                             Provider.of<TransactionDBProvider>(context,
//                                     listen: false)
//                                 .graphList = Provider.of<TransactionDBProvider>(
//                                     context,
//                                     listen: false)
//                                 .transactionList
//                                 .where(
//                                   (element) =>
//                                       element.datetime.day ==
//                                           DateTime.now().day - 1 &&
//                                       element.datetime.month ==
//                                           DateTime.now().month &&
//                                       element.datetime.year ==
//                                           DateTime.now().year,
//                                 )
//                                 .toList();

//                             value.dateFilterTitle = "Yesterday";
//                             Provider.of<StatisticsProvider>(context,
//                                     listen: false)
//                                 .changeValue(value.dateFilterTitle);
//                           },
//                         ),
//                         PopupMenuItem(
//                           value: 2,
//                           child: const Text(
//                             "Month",
//                           ),
//                           onTap: () {
//                             Provider.of<TransactionDBProvider>(context,
//                                     listen: false)
//                                 .graphList = Provider.of<TransactionDBProvider>(
//                                     context,
//                                     listen: false)
//                                 .transactionList
//                                 .where(
//                                   (element) =>
//                                       element.datetime.month ==
//                                           DateTime.now().month &&
//                                       element.datetime.year ==
//                                           DateTime.now().year,
//                                 )
//                                 .toList();

//                             value.dateFilterTitle = "Month";
//                             Provider.of<StatisticsProvider>(context,
//                                     listen: false)
//                                 .changeValue(value.dateFilterTitle);
//                           },
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: size.height * 0.02,
//           ),
//           Expanded(
//               child: DefaultTabController(
//                   length: 3,
//                   initialIndex: 0,
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         alignment: Alignment.center,
//                         width: double.infinity,
//                         child: ButtonsTabBar(
//                             backgroundColor: Colors.amber,
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: size.width * 0.1),
//                             tabs: const [
//                               Tab(
//                                 iconMargin: EdgeInsets.all(30),
//                                 text: 'All',
//                               ),
//                               Tab(
//                                 text: "Income",
//                               ),
//                               Tab(
//                                 text: "Expense",
//                               ),
//                             ]),
//                       ),
//                       const Expanded(
//                           child: TabBarView(children: [
//                         ScreenAll(),
//                         ScreenIncomeChart(),
//                         ScreenExpenseChart(),
//                       ]))
//                     ],
//                   )))
//         ],
//       ),
//     ));
//   }
// }
