import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import '../constants/style.dart';

String? passwordValidator(value) {
  if (value!.isEmpty) {
    return "Password cannot be empty";
  }
  if (value.length < 6) {
    return "Password must be atleast 6 characters long";
  }
  return null;
}

String? orgOrOccupationValidator(value) {
  if (value!.isEmpty) {
    return "This field is can't be empty";
  }
  return null;
}

String? phoneValidator(value) {
  if (value!.isEmpty || value.length < 10) {
    return 'Please enter a valid phone number';
  }
  return null;
}

String? nameValidator(value) {
  if (value!.isEmpty) {
    return 'Please enter your name';
  }
  return null;
}

String? emailValidator(value) {
  if (value!.isEmpty || !value.contains('@') || !value.contains('.')) {
    return 'Please enter a valid email';
  }
  return null;
}

String? notNullValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return null;
}

void errorToast(
    BuildContext context, String errorMessage, TextStyle mssgStyle) {
  MotionToast(
    icon: Icons.error,
    primaryColor: kDeleteRedColor,
    secondaryColor: kDeleteRedColor,
    description: Text(errorMessage, style: mssgStyle),
  ).show(context);
}
