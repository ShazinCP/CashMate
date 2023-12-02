import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/views/intro/button.dart';
import 'package:cashmate/views/intro/secondscreen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.5,
                width: size.width * 0.9,
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.07),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('photos/FirstScreen Image.png'),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                "Let's \n Manage\n  money with us",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.1,
                  shadows: const <Shadow>[
                    Shadow(
                      offset: Offset(1, 1),
                      color: cYellowARGBColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.1,
                    left: size.width * 0.07),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecondScreen()),
                    );
                  },
                  child: button(
                      size.width * 0.3,
                      size.height * 0.05,
                      'Start',
                      size.width *
                          0.05),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}