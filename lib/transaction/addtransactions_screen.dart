import 'package:cashmate/db_functions/income_expence.dart';
import 'package:cashmate/db_functions/transactionDB.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:cashmate/views/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime date = DateTime.now();

  String? selectedIN;

  // CategoryModel? selectedCategoryModel;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController explainController = TextEditingController();

  String? selctedItem;

  FocusNode ex = FocusNode();

  final TextEditingController amountcontroller = TextEditingController();

  FocusNode amount = FocusNode();

  final List<String> _iteminex = ['income', 'expense'];

  final List<String> _item = [
    'food',
    "Hospital",
    "Transportation",
    "Education",
    "Clothing",
    "Other"
  ];

  void initstate() {
    super.initState();
    IncomeAndExpence().income();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          backgroundContainer(context),
          // ignore: avoid_unnecessary_containers
          Container(
            //width: screenWidth * 0.9,
            child: SingleChildScrollView(child: mainContainer()),
          )
        ],
      )),
    );
  }

  Container mainContainer() {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      // SizedBox(height: screenHeight * .08),

      /* height: 550,
       width: 340, */
      height: size.height * 0.7,
      width: size.width * 0.9,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            type(),
            const SizedBox(
              height: 20,
            ),
            name(),
            const SizedBox(
              height: 20,
            ),
            explain(),
            const SizedBox(
              height: 20,
            ),
            transactionAmount(),
            const SizedBox(
              height: 20,
            ),
            dateTime(),
            const SizedBox(
              height: 27,
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  addTransaction();
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
            const SizedBox(
              height: 20,
            ),
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
            border: Border.all(width: 2, color: Colors.grey)),
        width: 300,
        child: TextButton(
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2100));
            // ignore: unrelated_type_equality_checks
            if (newDate == null) {
              return;
            } else {
              setState(() {
                date = newDate;
              });
            }
          },
          child: Text(
            'Date : ${date.year}/${date.month}/${date.day}',
            style: const TextStyle(
                fontSize: 16,
                //fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
        ));
  }

  Padding type() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 2,
                color: Colors.grey,
              )),
          child: DropdownButtonFormField<String>(
            value: selectedIN,

            onChanged: ((value) {
              setState(() {
                selectedIN = value!;
              });
            }),

            items: _iteminex
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          Image.asset(
                            'pictures/$e.png',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
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
              style: TextStyle(color: Colors.grey),
            ),
            dropdownColor: Colors.white,
            isExpanded: true,
            //underline: Container(),
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Select type';
            //   } else {
            //     return null;
            //   }
            // },
          )),
    );
  }

  Padding transactionAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
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
          focusNode: amount,
          controller: amountcontroller,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Amount',
            labelStyle: const TextStyle(fontSize: 17, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 2, color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(width: 2, color: Colors.green)),
          ),
        ),
      ),
    );
  }

  Padding explain() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child: TextField(
          focusNode: ex,
          controller: explainController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'explain',
            labelStyle: const TextStyle(fontSize: 17, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 2, color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(width: 2, color: Colors.green)),
          ),
        ),
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: const Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButtonFormField<String>(
          value: selctedItem,
          onChanged: (value) {
            setState(() {
              selctedItem = value!;
            });
          },
          items: _item
              .map(
                (e) => DropdownMenuItem<String>(
                  // ignore: sort_child_properties_last
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Image.asset('images/$e.png'),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          e,
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  value: e,
                ),
              )
              .toList(),
          selectedItemBuilder: (BuildContext context) => _item
              .map(
                (e) => Row(
                  children: [
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: 42,
                      child: Image.asset('images/$e.png'),
                    ),
                    const SizedBox(width: 5),
                    Text(e),
                  ],
                ),
              )
              .toList(),
          decoration: const InputDecoration(
            hintText: 'Category',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
        ),
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
            color: Color(0xff368983),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
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
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Center(
                      child: Text(
                        'Add Transaction',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    const Icon(
                      Icons.add_task_rounded,
                      color: Color(0xff368983),
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
    final model = MoneyModel(
        IN: selectedIN!,
        amount: amountcontroller.text,
        datetime: date,
        explain: explainController.text,
        name: selctedItem!,
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
        backgroundColor: Color(0xff368983),
      ),
    );
    limitCheck(selectedIN!);
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
                    style: TextStyle(color: Colors.red),
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
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              );
            });
      }
    }
  }
}
