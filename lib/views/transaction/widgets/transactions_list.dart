// import 'package:cashmate/controller/statistics_provider.dart';
// import 'package:cashmate/controller/transactiondb_provider.dart';
// import 'package:cashmate/model/data_model.dart';
// import 'package:cashmate/views/transaction/widgets/slidable_transaction.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class TransactionsList extends StatelessWidget {
//   const TransactionsList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<TransactionDBProvider>(context,listen: false);
//     final Size size = MediaQuery.of(context).size;
//     final double screenHeight = size.height;
//     provider.getAllTransactions();
//     return Consumer2<StatisticsProvider,TransactionDBProvider>(
//         // valueListenable: overViewListNotifier,
//         // builder: (BuildContext context, newList, Widget? _) {
//           builder: (context, staticticProvider, dbProvider, child) {
//           // return ValueListenableBuilder(
//               // valueListenable: showCategory,
//               // builder: (context, showcategorylist, child) {
//                 var displayList = [];

//                 if (staticticProvider.dateFilterTitle == 'income') {
//                   List<MoneyModel> incomeTransactionList = [];
//                   incomeTransactionList = provider.transactionList
//                       .where((element) => element.type == 'income')
//                       .toList();
//                   displayList = incomeTransactionList;
//                 } else if (staticticProvider.dateFilterTitle == "Expense") {
//                   List<MoneyModel> expenseTransactionList = [];
//                   expenseTransactionList = provider.transactionList
//                       .where((element) => element.type == 'expense')
//                       .toList();
//                   displayList = expenseTransactionList;
//                 } else {
//                   displayList = provider.transactionList;
//                 }

//                 return (displayList.isEmpty)
//                     ? SingleChildScrollView(
//                         child: Column(
//                         children: [
//                           SizedBox(height: screenHeight / 10),
//                           Center(
//                             child: Image.asset(
//                               "photos/Empty Box.png",
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           const Center(
//                             child: Text('No transactions added yet'),
//                           ),
//                         ],
//                       ))
//                     : ListView.separated(
//                         padding: const EdgeInsets.all(5),
//                         itemBuilder: (ctx, index) {
//                           final transaction = displayList[index];
//                           return SlidableTransaction(transaction: transaction);
//                         },
//                         separatorBuilder: (ctx, index) {
//                           return const Divider(
//                             height: 5,
//                             thickness: 5,
//                           );
//                         },
//                         itemCount: displayList.length);
//               });
//         }
//   }
