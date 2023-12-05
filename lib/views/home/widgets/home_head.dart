import 'package:cashmate/controller/utility_provider.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/views/transaction/widgets/addlimit_screen.dart';
import 'package:flutter/material.dart';

class HomeHead extends StatelessWidget {
  const HomeHead({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * 0.3,
              decoration: const BoxDecoration(
                  color: cAppThemeColor,
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
                          children: [
                            const Text(
                              'Hello there,',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19,
                                  color: cWhiteARGBColor2),
                            ),
                            SizedBox(
                              width: screenWidth * .6,

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
                                color: cWhiteColor,
                              ),
                            )
                          ],
                        ),
                        const Text(
                          'Welcome back!',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 19,
                              color: cWhiteARGBColor2),
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
                  170,
              width:
                  320,
              decoration: BoxDecoration(
              boxShadow: const [
                 BoxShadow(
                  color: cShadowColor,
                  offset: Offset(0, 6),
                  blurRadius: 12,
                  spreadRadius: 6,
                ),
              ],
              color: cShadowColor2,
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
                            color: cWhiteColor,)),
                  ),
                  const SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text('₹ ${UtilityProvider().total()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: cWhiteColor,)),
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
                              backgroundColor: cGreenColor,
                              child: Icon(
                                Icons.arrow_upward,
                                color: cWhiteColor,
                                size: 19,
                              ),
                            ),
                            SizedBox(width: 7),
                            Text('Income',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                     color: cWhiteARGBColor)),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: cRedColor,
                              child: Icon(
                                Icons.arrow_downward,
                                color: cWhiteColor,
                                size: 19,
                              ),
                            ),
                            SizedBox(width: 7),
                            Text('Expense',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: cWhiteARGBColor)),
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
                        Text('₹ ${UtilityProvider().income()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                                color: cGreenARGBColor)),
                        Text('₹ ${UtilityProvider().expense()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                                color: cRedColor),
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