import 'package:cashmate/constants/sizedbox.dart';
import 'package:cashmate/helper/colors.dart';
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
            cWidth10,
              TypeFilterClass(),
             cWidth20,
            ],
            flexibleSpace: Container(
              color: cAppThemeColor,
            ),
            title: const Text('Transactions'),
            centerTitle: true,
          ),
          body:   Column(
            children: [
              SearchField(),
              const Expanded(
                child: Transactions(),
              ),
            ],
          ),
          ),
    );
  }
}