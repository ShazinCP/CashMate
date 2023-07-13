import 'package:cashmate/db_functions/income_expence.dart';
import 'package:cashmate/transaction/addlimit_screen.dart';
// import 'package:cashflow/widgets/limit.dart';
import 'package:flutter/material.dart';

class HomeHead extends StatefulWidget {
  const HomeHead({super.key});

  @override
  State<HomeHead> createState() => _HomeHeadState();
}

class _HomeHeadState extends State<HomeHead> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    // ignore: unused_local_variable
    TextEditingController limitController = TextEditingController();
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * 0.3,
              //240,
              decoration: const BoxDecoration(
                  color: Color(0xff368983),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Hello there,',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19,
                                  color: Color.fromARGB(255, 224, 223, 223)),
                            ),
                            SizedBox(
                              width: screenWidth * .6,
                              //230,
                            ),
                            GestureDetector(
                              onTap: () async {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) => const Limit()));
                              },
                              child: const Icon(
                                Icons.add_box,
                                size: 30,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        const Text(
                          'Welcome back!',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 19,
                              color: Color.fromARGB(255, 224, 223, 223)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.15),
            child: Container(
              height:
                  //screenHeight * 0.2,
                  170,
              width:
                  //screenWidth * 0.6,
                  320,
              decoration: BoxDecoration(
              boxShadow: const [
                 BoxShadow(
                  color: Color.fromRGBO(47, 125, 121, 0.3),
                  offset: Offset(0, 6),
                  blurRadius: 12,
                  spreadRadius: 6,
                ),
              ],
              color: const Color.fromARGB(255, 47, 125, 121),
              borderRadius: BorderRadius.circular(15),
            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Total Balance',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: Colors.white,)),
                  ),
                  const SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text('₹ ${IncomeAndExpence().total()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: Colors.white,)),
                  ),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.arrow_upward,
                                color: Colors.white,
                                size: 19,
                              ),
                            ),
                            SizedBox(width: 7),
                            Text('Income',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                     color: Color.fromARGB(255, 216, 216, 216),)),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.arrow_downward,
                                color: Colors.white,
                                size: 19,
                              ),
                            ),
                            SizedBox(width: 7),
                            Text('Expense',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 216, 216, 216),)),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('₹ ${IncomeAndExpence().income()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                                color: Color.fromARGB(255, 71, 192, 75))),
                        /* const SizedBox(
                        width: 155,
                      ), */
                        Text('₹ ${IncomeAndExpence().expense()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                                color: Colors.red),
                                ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}