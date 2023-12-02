import 'package:cashmate/views/intro/button.dart';
import 'package:cashmate/views/intro/login.dart';
import 'package:cashmate/views/intro/thirdscreen.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double imageHeight = size.height * .5;
    final double textSize = size.width * 0.05;
    final double buttonWidth = size.width * 0.3;
    final double buttonHeight = size.height * 0.05;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: imageHeight,
              child: Image.asset('photos/SecondScreen Image.png'),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              
               '"Track your\nEarnings and\nspending with us."',
              style: TextStyle(fontSize: 37, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            // SizedBox(height: screenHeight * .01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.1
                      //40
                      ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: button(buttonWidth, buttonHeight, 'Skip', textSize),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.1),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ThirdScreen()),
                      );
                    },
                    child: button(buttonWidth, buttonHeight, 'Next', textSize),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}