import 'package:cashmate/widgets/filter/date_filter_transaction.dart';
import 'package:cashmate/widgets/filter/type_filter_transaction.dart';
import 'package:cashmate/views/transaction/transactions_screen.dart';
import 'package:cashmate/services/transactionDB.dart';
import 'package:cashmate/widgets/searchfield.dart';
import 'package:flutter/material.dart';


ValueNotifier showCategory = ValueNotifier('All');

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  ValueNotifier showCategory = ValueNotifier('All');
  // TextEditingController amountC = TextEditingController();

  @override
  void initState() {
    overViewListNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions:  const [
              DateFilterTransaction(),
              SizedBox(
                width: 10,
              ),
              TypeFilterClass(),
              SizedBox(
                width: 20,
              ),
            ],
            flexibleSpace: Container(
              color: const Color(0xff368983),
            ),
            title: const Center(
              child: Text('Transactions'),
            ),
            centerTitle: true,
          ),
          body:  const Column(
            children: [
              SearchField(),
              Expanded(
                child: Transactions(),
              ),
            ],
          ),
          ),
    );
  }
}

// popoutfuction(BuildContext context) {
//   return Navigator.of(context).pop();
// }

// String parseDate(DateTime date) {
//   return '${date.year} ${DateFormat.MMMd().format(date)}-${day[date.weekday - 1]}';
// }