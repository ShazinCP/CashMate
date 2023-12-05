import 'package:cashmate/controller/login_provider.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/main.dart';
import 'package:cashmate/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<LoginProvider>(
          builder: (context, provider, child) {
            return SizedBox(
              height: screenHeight,
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Center(
                    child: SizedBox(
                      height: 300,
                      width: 300,
                      child: Image.asset(
                        'photos/LoginScreen Image.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Form(
                    key: provider.formKey,
                    child: SizedBox(
                      width: screenWidth * .7,
                      height: screenHeight * .08,
                      child: TextFormField(
                        controller: provider.usernameController,
                        decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Username'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Name';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: GestureDetector(
                      onTap: () {
                        if (provider.formKey.currentState!.validate()) {
                          checkLogin(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomBar()),
                          );
                        }
                        provider.usernameController.clear();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: cAppThemeColor,
                        ),
                        width: size.width * 0.3,
                        height: size.height * 0.06,
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontFamily: 'f',
                            fontWeight: FontWeight.w600,
                            color: cWhiteColor,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void checkLogin(BuildContext ctx) async {
    final provider = Provider.of<LoginProvider>(ctx, listen: false);
    final username = provider.usernameController.text;

    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(saveKeyName, true);
    await sharedPref.setString('username', username);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        ctx, MaterialPageRoute(builder: (ctx1) => BottomBar()));
  }
}
