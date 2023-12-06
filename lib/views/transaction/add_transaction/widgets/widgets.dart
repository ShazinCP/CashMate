 import 'package:cashmate/constants/sizedbox.dart';
import 'package:cashmate/controller/provider_transaction.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  Container dateTime() {
    return Container(
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: cGreyColor)),
        width: 300,
        child: Consumer<ProviderTransaction>(
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

 

  Padding transactionAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<ProviderTransaction>(
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
      child: Consumer<ProviderTransaction>(
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