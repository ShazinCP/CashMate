import 'package:cashmate/views/intro/button.dart';
import 'package:cashmate/views/intro/login.dart';
import 'package:flutter/material.dart';


class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    final double buttonWidth = size.width * 0.3;
    final double buttonHeight = size.height * 0.05;
    final double textSize = size.width * 0.05;

    final double imageHeight = size.height * .5;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: imageHeight,
              child: Image.asset(
                'photos/ThirdScreen Image.png',
                height: screenHeight * 0.6,
                width: screenWidth * 0.8,
              ),
            ),
            //SizedBox(height: screenHeight * .04),
            SizedBox(
              // padding: EdgeInsets.only(top: screenHeight * 0.04),
              width: screenWidth * 0.7,
              height: screenHeight * 0.25,
              child: const Text(
               '"Financial control made easy\nManage. Budget. \n Save."',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.w500
                  //24,
                ),
              ),
            ),
            // SizedBox(height: screenHeight * .03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.1),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: button(
                      buttonWidth,
                      buttonHeight,
                      'Skip',
                      textSize,
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.1),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: button(
                      buttonWidth,
                      buttonHeight,
                      'Next',
                      textSize,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}