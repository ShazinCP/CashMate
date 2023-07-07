// import 'package:flutter/material.dart';

// class StatisticsScreen extends StatefulWidget {
//   const StatisticsScreen({super.key});

//   @override
//   State<StatisticsScreen> createState() => _StatisticsScreenState();
// }

// class _StatisticsScreenState extends State<StatisticsScreen> {
//   var selectedOption;

//   List<String> titles = ['All', 'Income', 'Expence'];

//   int current = 0;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xff368983),
//           title: const Center(
//             child: Text(
//               "Statistics",
//               style: TextStyle(fontSize: 25),
//             ),
//           ),
//         ),
//         body: Column(
//           children: [
//             Row(
//               children: [
//                 const Text(
//                   "  Date",
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8, top: 2),
//                   child: DropdownButton<String>(
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     value: selectedOption,
//                     onChanged: (var newValue) {
//                       setState(() {
//                         selectedOption = newValue;
//                       });
//                     },
//                     hint: const Text("All",style: TextStyle(color: Colors.black),),
//                     items: <String>['All', 'Today', 'Yesterday', 'Month']
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                     ),
//                     dropdownColor: Colors.white,
//                     underline: Container(),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 60,
//               width: 400,
//               child: ListView.builder(
//                 itemCount: titles.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (ctx, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 10, top: 10),
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           current = index;
//                         });
//                       },
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 300),
//                         margin: const EdgeInsets.all(3),
//                         height: 110,
//                         width: 110,
//                         decoration: BoxDecoration(
//                             color: current == index
//                                 ? Color.fromARGB(255, 21, 126, 119)
//                                 : Colors.grey[200],
//                             borderRadius: current == index
//                                 ? BorderRadius.circular(15)
//                                 : BorderRadius.circular(8)),
//                         child: Center(
//                           child: Text(
//                             titles[index],
//                             style:  TextStyle(fontSize: 18,
//                             color: current == index
//                             ? Colors.white
//                             : Colors.black
//                             ),

//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 80),
//               child: Container(
//                 height: 340,
//                 width: 340,
//                 decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 42, 172, 163),
//                     borderRadius: BorderRadius.circular(170)),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cashmate/db_functions/transactionDB.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:cashmate/statistics/staistics_income.dart';
import 'package:cashmate/statistics/statistics_all.dart';
import 'package:cashmate/statistics/statistics_expences.dart';
import 'package:flutter/material.dart';

ValueNotifier<List<MoneyModel>> overViewGraphNotifier =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _TransactionInsightsAllState();
}

class _TransactionInsightsAllState extends State<StatisticsScreen> {
  String dateFilterTitle = "All";

  @override
  void initState() {
    super.initState();
    overViewGraphNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 245, 245),
      appBar: AppBar(
        backgroundColor: const Color(0xff368983),
        title: const Center(
          child: Text(
            "Statistics",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text(
                  'Date  ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PopupMenuButton<int>(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      70,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 15.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          dateFilterTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: const Text(
                        "All",
                      ),
                      onTap: () {
                        overViewGraphNotifier.value = TransactionDB
                            .instance.transactionListNotifier.value;
                        setState(() {
                          dateFilterTitle = "All";
                        });
                      },
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: const Text(
                        "Today",
                      ),
                      onTap: () {
                        overViewGraphNotifier.value = TransactionDB
                            .instance.transactionListNotifier.value;
                        overViewGraphNotifier.value = overViewGraphNotifier
                            .value
                            .where((element) =>
                                element.datetime.day == DateTime.now().day &&
                                element.datetime.month ==
                                    DateTime.now().month &&
                                element.datetime.year == DateTime.now().year)
                            .toList();
                        setState(() {
                          dateFilterTitle = "Today";
                        });
                      },
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: const Text(
                        "Yesterday",
                      ),
                      onTap: () {
                        overViewGraphNotifier.value = TransactionDB
                            .instance.transactionListNotifier.value;
                        overViewGraphNotifier.value = overViewGraphNotifier
                            .value
                            .where((element) =>
                                element.datetime.day ==
                                    DateTime.now().day - 1 &&
                                element.datetime.month ==
                                    DateTime.now().month &&
                                element.datetime.year == DateTime.now().year)
                            .toList();
                        setState(() {
                          dateFilterTitle = "Yesterday";
                        });
                      },
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: const Text(
                        "Month",
                      ),
                      onTap: () {
                        overViewGraphNotifier.value = TransactionDB
                            .instance.transactionListNotifier.value;

                        overViewGraphNotifier.value = overViewGraphNotifier
                            .value
                            .where((element) =>
                                element.datetime.month ==
                                    DateTime.now().month &&
                                element.datetime.year == DateTime.now().year)
                            .toList();
                        setState(() {
                          dateFilterTitle = "Month";
                        });
                      },
                    ),
                  ],
                ),
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
                    // transformAlignment: Alignment.center,

                    width: double.infinity,
                    child: ButtonsTabBar(
                      backgroundColor: Colors.amber,
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
                      child: TabBarView(children: [
                    ScreenAll(),
                    ScreenIncomeChart(),
                    ScreenExpenseChart(),
                  ]))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
