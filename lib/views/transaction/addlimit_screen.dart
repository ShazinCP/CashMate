// import 'package:cashmate/widgets/home_screen.dart';
// import 'package:flutter/material.dart';

// class AddLimit extends StatelessWidget {
//   const AddLimit({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: const Color(0xff368983),
//         title: const Text(
//           "Add Limit",
//           style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 150, left: 40, right: 40),
//             child: TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter Limit',
//                 // filled: true,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 30, ),
//             child: Container(
//               height: 55,
//               width: 110,
//               decoration: const BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               child: OutlinedButton(
//                 onPressed: () {
//                   Navigator.of(context)
//                       .pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
//                 },
//                 child: const Text("Save",
//                     style: TextStyle(color: Colors.white, fontSize: 20)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
    // print('limitpage');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff368983),
        title: const Text(
          "Add Limit",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        // ignore: avoid_unnecessary_containers
        child: Container(
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
                            const TextStyle(fontSize: 17, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(width: 2, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.green)),
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
                        style: TextStyle(color: Colors.white, fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xff368983),
                  ),
                  width: 120,
                  height: 50,
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
              ),
            ],
          ),
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
