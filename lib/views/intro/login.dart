import 'package:cashmate/main.dart';
import 'package:cashmate/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _usernameController = TextEditingController();

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        // ignore: sized_box_for_whitespace
        child: Container(
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
                key: _formKey,
                child: SizedBox(
                  width: screenWidth * .7,
                  height: screenHeight * .08,
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        isDense: true,
                        // contentPadding: EdgeInsets.symmetric(
                        //     vertical: screenHeight * 0.01,
                        //     horizontal: screenHeight * 0.01),
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
              // SizedBox(height: screenHeight * .09),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      checkLogin(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BottomBar()),
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xff368983),
                    ),
                    width: size.width * 0.3,
                    height: size.height * 0.06,
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontFamily: 'f',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  // child: button(size.width * 0.3, size.height * 0.05, 'Login',
                  // size.width * 0.05),
                  // button(120, 50, 'Login', textSize),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkLogin(BuildContext ctx) async {
    final username = _usernameController.text;

    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(saveKeyName, true);
    await sharedPref.setString('username', username);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        ctx, MaterialPageRoute(builder: (ctx1) => BottomBar()));
  }
}
