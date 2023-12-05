import 'package:cashmate/controller/transactiondb_provider.dart';
import 'package:cashmate/views/transaction/widgets/slidable_transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionExpence extends StatelessWidget {
  const TransactionExpence({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionDBProvider>(
      builder: (context, value, child) {
        var expenseList = value.transactionList
            .where(
              (element) => element.type == 'expense',
            )
            .toList();
        return (expenseList.isEmpty)
            ? Image.asset("photos/Empty Box.png")
            : ListView.separated(
                padding: const EdgeInsets.all(5),
                itemBuilder: (ctx, index) {
                  final transaction = expenseList[index];
                  return SlidableTransaction(transaction: transaction);
                },
                separatorBuilder: (ctx, index) {
                  return const Divider(
                    height: 5,
                    thickness: 5,
                  );
                },
                itemCount: expenseList.length);
      },
    );
  }
}
