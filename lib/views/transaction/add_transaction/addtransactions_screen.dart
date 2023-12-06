import 'package:cashmate/constants/sizedbox.dart';
import 'package:cashmate/controller/provider_transaction.dart';
import 'package:cashmate/controller/transactiondb_provider.dart';
import 'package:cashmate/controller/utility_provider.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:cashmate/views/transaction/add_transaction/widgets/widgets.dart';
import 'package:cashmate/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {

  void initstate() {
    super.initState();
    UtilityProvider().income();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cGreyColorWithShade,
      body: SafeArea(
          child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          backgroundContainer(context),
          SingleChildScrollView(child: mainContainer())
        ],
      )),
    );
  }

  Container mainContainer() {
    final Size size = MediaQuery.of(context).size;
    final provider = Provider.of<ProviderTransaction>(context,listen: false);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: cWhiteColor),
      height: size.height * 0.7,
      width: size.width * 0.9,
      child: Form(
        key: provider.formKey,
        child: Column(
          children: [
          cHeight25,
            type(),
          cHeight20,
            name(),
           cHeight20,
            explain(),
           cHeight20,
            transactionAmount(),
            cHeight20,
            dateTime(),
          cHeight27,
            GestureDetector(
              onTap: () {
                if (provider.formKey.currentState!.validate()) {
                  addTransaction();
                  provider.amountcontroller.clear();
                  provider.explainController.clear();
                  provider.selectedItem = null;
                  provider.selectedType = null;
                  provider.date = DateTime.now();
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
          cHeight20,
          ],
        ),
      ),
    );
  }

  
  Future addTransaction() async {
    final transactionProvider = Provider.of<ProviderTransaction>(context,listen: false);
    final dbProvider = Provider.of<TransactionDBProvider>(context,listen: false);
    final model = MoneyModel(
        type: transactionProvider.selectedType!,
        amount: transactionProvider.amountcontroller.text,
        datetime: transactionProvider.date,
        explain: transactionProvider.explainController.text,
        name: transactionProvider.selectedItem!,
        id: DateTime.now().microsecondsSinceEpoch.toString());

    await dbProvider.insertTransaction(model);


    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => BottomBar(),
    ));
    dbProvider.getAllTransactions();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Transaction Added Successfully',
          textAlign: TextAlign.center,
        ),
        
        duration: Duration(seconds: 3),
        backgroundColor: cAppThemeColor,
      ),
    );
    limitCheck(transactionProvider.selectedType!);
  }

  limitCheck(String finance) async {
    if (finance == 'expense') {
      final sharedPref = await SharedPreferences.getInstance();
      var limitvariable = sharedPref.getString('limit');

      int expense1 = UtilityProvider().expense();
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => BottomBar()));
      double limit = double.parse(limitvariable!);
      double expenses = expense1.toDouble();
      double eightyPercentOfLimit = limit * 0.8;

      if (expenses >= eightyPercentOfLimit && expenses < limit) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Align(
                  alignment: Alignment.center,
                  child: Text(
                    ' Expense has crossed \n   80% of the limit',
                    style: TextStyle(color: cRedColor),
                  ),
                ),
              );
            });
      }
      if (expenses >= limit) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Center(
                  child: Text(
                    'Expense has crossed \n the limit',
                    style: TextStyle(color: cRedColor),
                  ),
                ),
              );
            });
      }
    }
  }
}
