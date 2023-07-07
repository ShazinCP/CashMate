import 'package:cashmate/db_functions/transactionDB.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:cashmate/transaction/slidable_transaction.dart';
import 'package:cashmate/transaction/transaction_list.dart';
import 'package:flutter/material.dart';

ValueNotifier<List<MoneyModel>> overViewListNotifier =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // final double screenWidth = size.width;
    final double screenHeight = size.height;
    TransactionDB().getAllTransactions();
    return ValueListenableBuilder(
        valueListenable: overViewListNotifier,
        builder: (BuildContext context, newList, Widget? _) {
          return ValueListenableBuilder(
              valueListenable: showCategory,
              builder: (context, showcategorylist, child) {
                //here we building the list using displayList list
                var displayList = [];

                if (showCategory.value == 'income') {
                  //here i am creating an empty list for the transaction,
                  //so i can pick the income only through the where function
                  List<MoneyModel> incomeTransactionList = [];
                  //here i converting the element into list using toList function
                  incomeTransactionList = newList
                      .where((element) => element.IN == 'income')
                      .toList();
                  //assigning the list into displayList which is the list i declared above
                  displayList = incomeTransactionList;
                } else if (showCategory.value == "Expense") {
                  List<MoneyModel> expenseTransactionList = [];
                  expenseTransactionList = newList
                      .where((element) => element.IN == 'expense')
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
