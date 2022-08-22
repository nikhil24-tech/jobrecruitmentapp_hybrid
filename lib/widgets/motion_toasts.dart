import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import '../constants/style.dart';

void errorrToast(
    BuildContext context, String errorMessage, TextStyle mssgStyle) {
  MotionToast(
    icon: Icons.warning,
    primaryColor: kDeleteRedColor,
    secondaryColor: kDeleteRedColor,
    description: Text(errorMessage, style: mssgStyle),
    position: MotionToastPosition.top,
    animationType: AnimationType.fromTop,
  ).show(context);
}

void infoToast(BuildContext context, String errorMessage, TextStyle mssgStyle) {
  MotionToast(
    icon: Icons.info,
    primaryColor: kThemeColor1,
    secondaryColor: kThemeColor1,
    description: Text(errorMessage, style: mssgStyle),
    position: MotionToastPosition.top,
    animationType: AnimationType.fromTop,
  ).show(context);
}


void successToast(BuildContext context, String errorMessage, TextStyle mssgStyle) {
  MotionToast(
    icon: Icons.info,
    primaryColor: Colors.green,
    secondaryColor: Colors.green,
    description: Text(errorMessage, style: mssgStyle),
    position: MotionToastPosition.top,
    animationType: AnimationType.fromTop,
  ).show(context);
}

