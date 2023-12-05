import 'package:cashmate/controller/provider_transaction.dart';
import 'package:cashmate/controller/transactiondb_provider.dart';
import 'package:cashmate/controller/utility_provider.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/views/transaction/widgets/transaction_all.dart';
import 'package:cashmate/views/home/widgets/home_head.dart';
import 'package:cashmate/widgets/uppercase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<TransactionDBProvider>(context, listen: false);
    provider.getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Consumer<TransactionDBProvider>(
            builder: (context, provider, index) {
              return Column(
                children: [
                  SizedBox(
                    height: screenHeight * .44,
                    width: screenWidth,
                    child: HomeHead(
                      key: UniqueKey(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Recent Transactions',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: cBlackARGBColor2)),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const TransactionAll()));
                          },
                          child: const Text('See all',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: cBlackARGBColor2)),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: cWhiteColor24,
                      height: 300,
                      child: Consumer2<TransactionDBProvider,UtilityProvider>(
                        builder: (context, provider,provider2, child) {
                          return (provider.transactionList.isEmpty)
                              ? Column(
                                  children: [
                                    SizedBox(height: screenHeight / 14),
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
                                )
                              : ListView.separated(
                                  padding: const EdgeInsets.all(5),
                                  itemBuilder: (ctx, index) {
                                    final int lastIndex =
                                        provider2.transactionDB.length - 1;
                                    final int reversedIndex = lastIndex - index;
                                    final value =
                                        provider.transactionList[reversedIndex];
                                    return Card(
                                      color: cWhiteARGBColor5,
                                      elevation: 0,
                                      child: Consumer<ProviderTransaction>(
                                        builder: (context, provider, child) {
                                          return ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: cWhiteARGBColor4,
                                              radius: 50,
                                              child: Image.asset(
                                                  'images/${value.name}.png',
                                                  height: 40),
                                            ),
                                            title: Text(
                                              value.explain.capitalize(),
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '${value.datetime.year}-${value.datetime.day}-${value.datetime.month}  ${provider.days[value.datetime.weekday - 1]}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13),
                                            ),
                                            trailing: Text(
                                              value.amount,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 19,
                                                color: value.type == 'income'
                                                    ? cGreenColor
                                                    : cRedColor,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  separatorBuilder: (ctx, index) {
                                    return const Divider(
                                      height: 4,
                                      thickness: 2,
                                    );
                                  },
                                  itemCount: provider.transactionList.length > 4
                                      ? 4
                                      : provider.transactionList.length,
                                );
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
