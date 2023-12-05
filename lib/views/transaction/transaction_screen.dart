import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cashmate/constants/sizedbox.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/views/transaction/widgets/searchfield.dart';
import 'package:cashmate/views/transaction/widgets/transaction_all.dart';
import 'package:cashmate/views/transaction/widgets/transaction_expence.dart';
import 'package:cashmate/views/transaction/widgets/transaction_income.dart';
import 'package:cashmate/widgets/date_filter.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            DateFilterTransaction(),
            cWidth20,
          ],
          flexibleSpace: Container(
            color: cAppThemeColor,
          ),
          title: const Text('Transactions'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SearchField(),
            Expanded(
              child: DefaultTabController(
                length: 3,
                initialIndex: 0,
                child: Column(
                  children: <Widget>[
                    ButtonsTabBar(
                        backgroundColor: cAmberColor,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.1),
                        tabs: const [
                          Tab(
                            iconMargin: EdgeInsets.all(30),
                            text: 'All',
                          ),
                          Tab(
                            text: "Income",
                          ),
                          Tab(
                            text: "Expense",
                          ),
                        ]),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          TransactionAll(),
                          TransactionIncome(),
                          TransactionExpence()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
