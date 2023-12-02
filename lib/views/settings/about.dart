import 'package:cashmate/constants/sizedbox.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: cGreyColor,
          appBar: AppBar(
            backgroundColor: cAppThemeColor,
            title: const Text(
              "About",
              style: TextStyle(fontSize: 25),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Container(
              width: 250,
              height: 300,
              color: cGreyColor,
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 10,
                shadowColor: cWhiteColor,
                child: Column(
                  children: [
                    Title(
                        color: cBlackColor,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 30, left: 10),
                          child: Text(
                            'CashMate',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                        )),
                  cHeight30,
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 10),
                      child: Text(
                        '"This is an app where you can\nadd your daily transactions\naccording to the category which it belongs to."',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  cHeight40,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Developed by',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    cHeight5,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Shazin Muhammed Cp',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
