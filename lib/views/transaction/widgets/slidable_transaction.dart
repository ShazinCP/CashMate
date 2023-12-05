import 'package:cashmate/controller/provider_transaction.dart';
import 'package:cashmate/controller/transactiondb_provider.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:cashmate/views/transaction/edit_transaction/edit_screen.dart';
import 'package:cashmate/widgets/uppercase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';


class SlidableTransaction extends StatelessWidget {
  const SlidableTransaction({super.key, required this.transaction});

  final MoneyModel transaction;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: ((context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) {
                  return EditTransaction(obj: transaction);
                }),
              ),
            );
          }),
          icon: Icons.edit,
          foregroundColor: cBlueColor,
        ),
        SlidableAction(
          onPressed: ((context) async {
            final value = Provider.of<TransactionDBProvider>(context,listen: false);
            await value.deleteTransaction(transaction);
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          }),
          icon: Icons.delete,
          foregroundColor: cRedColor,
        ),
      ]),
      child: Card(
        color: cWhiteColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Consumer<ProviderTransaction>(
          builder: (context, provider, child) {
            return    ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset('images/${transaction.name}.png',
                  height: 40),
            ),
            title: Text(
              transaction.explain.capitalize(),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              '${transaction.datetime.year}-${transaction.datetime.day}-${transaction.datetime.month}  ${provider.days[transaction.datetime.weekday - 1]}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13
              ),
            ),
            trailing: Text(
              transaction.amount,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 19,
                color: transaction.type == 'income' ? cGreenColor : cRedColor,
              ),
            ),
          );
          },
        ),
      ),
    );
  }
}
