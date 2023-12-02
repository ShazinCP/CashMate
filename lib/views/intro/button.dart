import 'package:cashmate/helper/colors.dart';
import 'package:flutter/material.dart';

button(
  double width,
  double height,
  String text,
  double fontsize,
) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: cBlackColor,
    ),
    width: width,
    height: height,
    child: Text(
      text,
      style: TextStyle(
        fontSize: fontsize,
        fontWeight: FontWeight.w500,
        color: cWhiteColor,
      ),
    ),
  );
}
