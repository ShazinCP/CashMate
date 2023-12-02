import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/services/income_expence.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController limitController = TextEditingController();
// ignore: prefer_typing_uninitialized_variables
var limit;
// ignore: prefer_typing_uninitialized_variables
var expense1;

class Limit extends StatefulWidget {
  const Limit({
    Key? key,
  }) : super(key: key);

  @override
  State<Limit> createState() => _LimitState();
}

class _LimitState extends State<Limit> {
  DateTime? startDate, endDate;

  @override
  void initState() {
    super.initState();
    new1();
  }

  void new1() async {
    final sharedPref = await SharedPreferences.getInstance();
    var limitvariable = sharedPref.getString('limit');
    //limitController.text = limitvariable;
    if (limitvariable != null) {
      limitController.text = limitvariable;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: cAppThemeColor,
        title: const Text(
          "Add Limit",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding:
                    //const EdgeInsets.symmetric(horizontal: 15, vertical: 100),
                    const EdgeInsets.only(top: 200),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    //focusNode: ex,
                    controller: limitController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      labelText: 'Enter Limit',
                      labelStyle:
                          const TextStyle(fontSize: 17, color: cGreyColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 2, color: cBlackColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(width: 2, color: cGreyColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2, color: cGreenColor)),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                limit = limitController.text;
                Navigator.of(context).pop();
                expense1 = IncomeAndExpence().expense();

                checkLimit(context);
                if (!RegExp(r'^\d+$').hasMatch(limit)) {
                  // Show an error message
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Please enter a valide number..!!!',
                      style: TextStyle(color: cWhiteColor, fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: cRedColor,
                  ));
                  return;
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: cAppThemeColor,
                ),
                width: 120,
                height: 50,
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
          ],
        ),
      ),
    );
  }

  void checkLimit(BuildContext ctx) async {
    var limit = limitController.text;
    final sharedPref = await SharedPreferences.getInstance();

    sharedPref.setString('limit', limit);
    // var limitvariable = sharedPref.getString('limit');
  }
}
