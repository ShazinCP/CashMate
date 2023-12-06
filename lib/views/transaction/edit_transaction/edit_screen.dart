import 'package:cashmate/controller/provider_transaction.dart';
import 'package:cashmate/controller/transactiondb_provider.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    final provider = Provider.of<ProviderTransaction>(context,listen: false);
    super.initState();
    super.initState();
    provider.amountTextEditingController =
        TextEditingController(text: widget.obj.amount);
    provider.explainTextEditingController =
        TextEditingController(text: widget.obj.explain);
    provider.selectedEditDateTime = widget.obj.datetime;
    provider.selectedEditType = widget.obj.type;
    provider.selectedEditCategory = widget.obj.name;
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
    final value = Provider.of<ProviderTransaction>(context,listen: false);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: cWhiteColor),
      height: size.height * 0.7,
      width: size.width * 0.9,
      child: Form(
        key: value.formKey,
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
                if (value.formKey.currentState!.validate()) {
                  
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
      child: Consumer<ProviderTransaction>(
        builder: (context, value, child) {
          return TextButton(
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
            value.setDate(newDate);
          },
          child: Text(
            'Date : ${value.date.year}/${value.date.month}/${value.date.day}',
            style: const TextStyle(
                fontSize: 16,
                color: cBlackColor),
          ),
        );
        },
        
      ),
    );
  }


  Padding type() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<ProviderTransaction>(
        builder: (context, provider, child) {
          return Container(
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
                value: provider.selectedEditType,
      
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
            ));
        },
        
      ),
    );
  }


  Padding amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child: Consumer<ProviderTransaction>(
          builder: (context, provider, child) {
            return TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required Name';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.number,
            controller: provider.amountTextEditingController,
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
          );
          },
          
        ),
      ),
    );
  }


  Padding explain() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<ProviderTransaction>(
        builder: (context, provider, child) {
          return  SizedBox(
          width: 300,
          child: TextField(
            controller: provider.explainTextEditingController,
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
      child: Consumer<ProviderTransaction>(
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
            selectedItemBuilder: (BuildContext context) => provider.item
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
    final provider = Provider.of<TransactionDBProvider>(context,listen: false);
    final value = Provider.of<ProviderTransaction>(context,listen: false);
    final explainText = value.explainTextEditingController.text;
    final amountText = value.amountTextEditingController.text;

    final model = MoneyModel(
        type: value.selectedEditType!,
        amount: amountText,
        datetime: value.date,
        explain: explainText,
        name: value.selectedEditCategory!,
        id: widget.obj.id);

     await provider.editTransaction(model);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
