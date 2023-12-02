import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:cashmate/services/transactionDB.dart';
import 'package:cashmate/views/intro/firstscreen.dart';
import 'package:cashmate/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  TextEditingController limitchangecontroller = TextEditingController();
  editLimit(BuildContext context) async {
    final sharedPref = await SharedPreferences.getInstance();
    var limitvariable1 = sharedPref.getString('limit')!;
    limitchangecontroller =
        TextEditingController(text: limitvariable1);
    // ignore: use_build_context_synchronously
    showdialog(context);
  }

  showdialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter the Limit'),
            content: TextField(
              controller: limitchangecontroller,
              style: const TextStyle(fontSize: 20),
              keyboardType: TextInputType.number,
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    var newLimit = limitchangecontroller.text;
                    if (!RegExp(r'^\d+$').hasMatch(newLimit)) {
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

                    final sharedPref = await SharedPreferences.getInstance();
                    sharedPref.setString('limit', newLimit);

                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomBar()),
                    );
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(cRedAccentColor)),
                  child: const Text('Save'),
                ),
              )
            ],
          );
        });
  }

  resetApp(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: const Text(
              'Do you want to Reset the app?',
              style: TextStyle(color: cBlackColor, fontSize: 18),
            ),
            actions: [
              TextButton(
                  onPressed: (() async {
                    Navigator.of(context).pop();
                    final transactionDb =
                        await Hive.openBox<MoneyModel>(transactionDBName);

                    transactionDb.clear();

                    TransactionDB().transactionListNotifier.value.clear();
                    TransactionDB().transactionListNotifier.notifyListeners();

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const FirstScreen(),
                      ),
                    );
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await pref.clear();
                  }),
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      color: cRedColor,
                    ),
                  )),
              TextButton(
                onPressed: (() {
                  Navigator.of(context).pop();
                }),
                child: const Text(
                  'No',
                  style: TextStyle(color: cGreenColor),
                ),
              ),
            ],
          );
        });
  }
}
