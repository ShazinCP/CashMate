import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/services/transactionDB.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:flutter/material.dart';

class EditTransaction extends StatefulWidget {
  final String? id;
  final MoneyModel obj;

  const EditTransaction({
    super.key,
    required this.obj,
    this.id,
  });

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  DateTime date = DateTime.now();
  // ignore: unused_field
  DateTime? _selectedDateTime;
  String? _selectedtype;
  String? _selectedCategory;
  // ignore: unused_field
  int _value = 0;
  TextEditingController _amountTextEditingController = TextEditingController();
  TextEditingController _explainTextEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final List<String> _iteminex = ['income', 'expense'];

   final List<String> _item = [
    'food',
    "Hospital",
    "Transportation",
    "Education",
    "Clothing",
    "Other"
  ];

  @override
  void initState() {
    super.initState();

    super.initState();
    _value = int.parse(widget.obj.id);
    _amountTextEditingController =
        TextEditingController(text: widget.obj.amount);
    _explainTextEditingController =
        TextEditingController(text: widget.obj.explain);
    _selectedDateTime = widget.obj.datetime;
    _selectedtype = widget.obj.type;
    _selectedCategory = widget.obj.name;

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
          SingleChildScrollView(
            child: Container(
              child: mainContainer(),
            ),
          )
        ],
      )),
    );
  }

  Container mainContainer() {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: cWhiteColor),
      height: size.height * 0.7,
      width: size.width * 0.9,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
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
            amount(),
            const SizedBox(
              height: 20,
            ),
            dateTime(),
            const SizedBox(
              height: 20,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  
                  submitEditIncomeTransaction();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor:  cGreenARGBColor2,
                        content: Center(child: Text('Transaction Edited Successfully'))),
                  );
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
          border: Border.all(width: 2, color: cGreyColor)),
      width: 300,
      child: TextButton(
        //child: Text('${widget.obj.datetime}'),
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: widget.obj.datetime,
              //initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100));
          // ignore: unrelated_type_equality_checks
          if (newDate == Null) return;
          setState(() {
            date = newDate!;
          });
        },

        child: Text(
          'Date : ${date.year}/${date.month}/${date.day}',
          style: const TextStyle(
              fontSize: 16,
              color: cBlackColor),
        ),
      ),
    );
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
              color: cGreyColor,
            ),
          ),
          child: SingleChildScrollView(
            child: DropdownButtonFormField<String>(
              hint: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Image.asset('pictures/${widget.obj.type}.png'),
                  ),
                  Text(widget.obj.type,
                      style: const TextStyle(color: cBlackColor)),
                ],
              ),
              value: _selectedtype,

              onChanged: ((value) {
                setState(() {
                  _selectedtype = value!;
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

              dropdownColor: cWhiteColor,
              isExpanded: true,
            ),
          )),
    );
  }

  Padding amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required Name';
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.number,
          controller: _amountTextEditingController,
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
      ),
    );
  }

  Padding explain() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child: TextField(
          controller: _explainTextEditingController,
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
            color: cWhiteColor2,
          ),
        ),
        child: DropdownButtonFormField<String>(
           hint: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Image.asset('images/${widget.obj.name}.png'),
                ),
                Text('${widget.obj.name} ',
                    style: const TextStyle(color: cBlackColor)),
              ],
            ),
          onChanged: (value) {
            setState(() {
              _selectedCategory = value!;
            });
          },
          items: _item
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
                        const SizedBox(width: 10),
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
          selectedItemBuilder: (BuildContext context) => _item
              .map(
                (e) => Row(
                  children: [
                    SizedBox(
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
            hintStyle: TextStyle(color: cGreyColor),
            border: InputBorder.none,
          ),
          dropdownColor: cWhiteColor,
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
            color: cAppThemeColor,
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
                      child: const Icon(Icons.arrow_back, color: cWhiteColor),
                    ),
                    const Center(
                      child: Text(
                        'Edit Transaction',
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

  Future<void> submitEditIncomeTransaction() async {
    final explainText = _explainTextEditingController.text;
    final amountText = _amountTextEditingController.text;

    final model = MoneyModel(
        type: _selectedtype!,
        amount: amountText,
        datetime: date,
        explain: explainText,
        name: _selectedCategory!,
        id: widget.obj.id);

     await TransactionDB.instance.editTransaction(model);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
