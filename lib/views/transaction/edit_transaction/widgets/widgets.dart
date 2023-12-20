  import 'package:cashmate/helper/colors.dart';
import 'package:flutter/material.dart';

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

  