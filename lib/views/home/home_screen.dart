import 'package:cashmate/services/income_expence.dart';
import 'package:cashmate/services/transactionDB.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:cashmate/views/transaction/transactions_screen.dart';
import 'package:cashmate/views/home/home_head.dart';
import 'package:cashmate/widgets/uppercase.dart';
import 'package:flutter/material.dart';


final List<String> day = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var displayList = [];

  @override
  void initState() {
    overViewListNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
    super.initState();
    TransactionDB().transactionListNotifier;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: TransactionDB.instance.transactionListNotifier,
            //transactionDB.listenable(),
            builder: (context, value, index) {
              return Column(
                children: [
                  //HomeHead(),
                  SizedBox(
                      height: screenHeight * .44,
                      width: screenWidth,
                      child: HomeHead(
                        key: UniqueKey(),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         const Text('Recent Transactions',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Color.fromARGB(255, 15, 14, 14))),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Transactions()));
                          },
                          child:  const Text('See all',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 15, 14, 14))),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white24,
                      height: 300,
                      child: ValueListenableBuilder(
                          valueListenable:
                              TransactionDB.instance.transactionListNotifier,
                          builder: (BuildContext ctx,
                              List<MoneyModel> newList, Widget? _) {
                            return (newList.isEmpty)
                                ?  Column(
                                  children: [
                                     SizedBox(height: screenHeight/14),
                                    Center(
                                      child: Image.asset("photos/Empty Box.png",
                                      fit: BoxFit.fill,),
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
                                          transactionDB.length - 1;
                                      final int reversedIndex =
                                          lastIndex - index;
                                      final value = newList[reversedIndex];
                                      return Card(
                                        color: const Color.fromARGB(
                                            255, 248, 246, 246),
                                        elevation: 0,
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 244, 240, 228),
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
                                       '${value.datetime.year}-${value.datetime.day}-${value.datetime.month}  ${day[value.datetime.weekday - 1]}',
                                        style:  const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13
                                        ),
                                      ),
                                      trailing: Text(
                                        value.amount,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 19,
                                          color: value.type == 'income'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                          
                                        ),
                                      );
                                    },
                                    separatorBuilder: (ctx, index) {
                                      return const Divider(
                                        height: 4,
                                        thickness: 2,
                                      );
                                    },
                                    itemCount:
                                        newList.length > 4 ? 4 : newList.length,
                                  );
                          }),
                    ),
                  )
                ],
              );
            }),
      )),
    );
  }
}

// String parseDateTime(DateTime date) {
//   final dateFormatted = DateFormat.MMMMd().format(date);

//   final splitedDate = dateFormatted.split(' ');

//   return "${splitedDate.last}  ${splitedDate.first} ";
// }