import 'package:cashmate/constants/sizedbox.dart';
import 'package:cashmate/controller/transaction_provider.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/services/income_expence.dart';
import 'package:cashmate/services/transactionDB.dart';
import 'package:cashmate/model/data_model.dart';
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
    IncomeAndExpence().income();
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
    final provider = Provider.of<TransactionProvider>(context,listen: false);
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

  Container dateTime() {
    return Container(
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: cGreyColor)),
        width: 300,
        child: Consumer<TransactionProvider>(
          builder: (context, provider, child) {
            return TextButton(
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100));
        
              if (newDate == null) {
                return;
              } else {
              provider.setDate(newDate);
              }
            },
            child: Text(
              'Date : ${provider.date.year}/${provider.date.month}/${provider.date.day}',
              style: const TextStyle(
                  fontSize: 16,
                  color: cBlackColor),
            ),
          );
          },
        
        ));
  }

  Padding type() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: cGreyColor,
                )),
            child: DropdownButtonFormField<String>(
              value: provider.selectedType,
      
              onChanged: ((value) {
               provider.setSelectedType(value!);
              }),
              items: provider.iteminex
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Row(
                          children: [
                            Image.asset(
                              'pictures/$e.png',
                              width: 30,
                              height: 30,
                            ),
                          cHeight10,
                            Text(
                              e,
                              style: const TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ))
                  .toList(),
      
              hint: const Text(
                'Select',
                style: TextStyle(color: cGreyColor),
              ),
              dropdownColor: cWhiteColor,
              isExpanded: true,
              //underline: Container(),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Select type';
              //   } else {
              //     return null;
              //   }
              // },
            ));
        },
        
      ),
    );
  }

  Padding transactionAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          return  SizedBox(
          width: 300,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select Amount';
              } else if (value.contains(',')) {
                return 'Please remove special character';
              } else if (value.contains('.')) {
                return 'Please remove special character';
              } else if (value.contains(' ')) {
                return 'Please Enter a valid number';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.number,
            focusNode: provider.amount,
            controller: provider.amountcontroller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              labelText: 'Amount',
              labelStyle: const TextStyle(fontSize: 17, color: cGreyColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 2, color: cBlackColor),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 2, color: cGreyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(width: 2, color: cGreenColor)),
            ),
          ),
        );
        },
     
      ),
    );
  }

  Padding explain() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          return SizedBox(
          width: 300,
          child: TextField(
            focusNode: provider.ex,
            controller: provider.explainController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              labelText: 'explain',
              labelStyle: const TextStyle(fontSize: 17, color: cGreyColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 2, color: cBlackColor),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 2, color: cGreyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(width: 2, color: cGreenColor)),
            ),
          ),
        );
        },
        
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          return  Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: cWhiteColor2,
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: provider.selectedItem,
            onChanged: (value) {
             provider.setSelectedItem(value!);
            },
            items: provider.item
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Image.asset('images/$e.png'),
                          ),
                         cHeight10,
                          Text(
                            e,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
            selectedItemBuilder: (BuildContext context) => provider.item
                .map(
                  (e) => Row(
                    children: [
                      SizedBox(
                        width: 42,
                        child: Image.asset('images/$e.png'),
                      ),
                     cWidth5,
                      Text(e),
                    ],
                  ),
                )
                .toList(),
            decoration: const InputDecoration(
              hintText: 'Category',
              hintStyle: TextStyle(color: cGreyColor),
              border: InputBorder.none,
            ),
            dropdownColor: cWhiteColor,
            isExpanded: true,
          ),
        );
        },
        
      ),
    );
  }

  Column backgroundContainer(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: const BoxDecoration(
            color: cAppThemeColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              cHeight40,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back, color: cWhiteColor),
                    ),
                    const Center(
                      child: Text(
                        'Add Transaction',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: cWhiteColor),
                      ),
                    ),
                    const Icon(
                      Icons.add_task_rounded,
                      color: cAppThemeColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future addTransaction() async {
    final provider = Provider.of<TransactionProvider>(context,listen: false);
    final model = MoneyModel(
        type: provider.selectedType!,
        amount: provider.amountcontroller.text,
        datetime: provider.date,
        explain: provider.explainController.text,
        name: provider.selectedItem!,
        id: DateTime.now().microsecondsSinceEpoch.toString());

    await TransactionDB().insertTransaction(model);


    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => BottomBar(),
    ));
    TransactionDB.instance.getAllTransactions();
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
    limitCheck(provider.selectedType!);
  }

  limitCheck(String finance) async {
    if (finance == 'expense') {
      final sharedPref = await SharedPreferences.getInstance();
      var limitvariable = sharedPref.getString('limit');

      int expense1 = IncomeAndExpence().expense();
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
