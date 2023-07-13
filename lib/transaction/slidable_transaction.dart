// import 'package:cashflow/screens/home_screen.dart';
import 'package:cashmate/db_functions/transactionDB.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:cashmate/views/widgets/edit_screen.dart';
import 'package:cashmate/views/widgets/uppercase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class SlidableTransaction extends StatelessWidget {
  SlidableTransaction({super.key, required this.transaction});

  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];

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
          foregroundColor: const Color(0xFF2E49FB),
        ),
        SlidableAction(
          onPressed: ((context) async {
            await TransactionDB().deleteTransaction(transaction);
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          }),
          icon: Icons.delete,
          foregroundColor: Colors.red,
        ),
      ]),
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          //<-- SEE HERE
          // side: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
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
            '${transaction.datetime.year}-${transaction.datetime.day}-${transaction.datetime.month}  ${days[transaction.datetime.weekday - 1]}',
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
              color: transaction.IN == 'Income' ? Colors.green : Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  // String parseDate(DateTime date) {
  //   return '${days[date.weekday - 1]}-${date.year} ${DateFormat.MMMd().format(date)}';
  // }
}
