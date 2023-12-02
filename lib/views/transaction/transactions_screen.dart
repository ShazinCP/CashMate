import 'package:cashmate/services/transactionDB.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:cashmate/views/transaction/slidable_transaction.dart';
import 'package:cashmate/views/transaction/transaction_list.dart';
import 'package:flutter/material.dart';

ValueNotifier<List<MoneyModel>> overViewListNotifier =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    TransactionDB().getAllTransactions();
    return ValueListenableBuilder(
        valueListenable: overViewListNotifier,
        builder: (BuildContext context, newList, Widget? _) {
          return ValueListenableBuilder(
              valueListenable: showCategory,
              builder: (context, showcategorylist, child) {
                var displayList = [];

                if (showCategory.value == 'income') {
                  List<MoneyModel> incomeTransactionList = [];
                  incomeTransactionList = newList
                      .where((element) => element.type == 'income')
                      .toList();
                  displayList = incomeTransactionList;
                } else if (showCategory.value == "Expense") {
                  List<MoneyModel> expenseTransactionList = [];
                  expenseTransactionList = newList
                      .where((element) => element.type == 'expense')
                      .toList();
                  displayList = expenseTransactionList;
                } else {
                  displayList = newList;
                }

                return (displayList.isEmpty)
                    ? SingleChildScrollView(
                        child: Column(
                        children: [
                          SizedBox(height: screenHeight / 10),
                          Center(
                            child: Image.asset(
                              "photos/Empty Box.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Center(
                            child: Text('No transactions added yet'),
                          ),
                        ],
                      ))
                    : ListView.separated(
                        padding: const EdgeInsets.all(5),
                        itemBuilder: (ctx, index) {
                          final transaction = displayList[index];
                          return SlidableTransaction(transaction: transaction);
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider(
                            height: 5,
                            thickness: 5,
                          );
                        },
                        itemCount: displayList.length);
              });
        });
  }
}
