import 'package:flutter/material.dart';

class AppColors {
  static final primaryColor = makeColor('099397');
  static final borderColor = makeColor('65B2E3');
  static final greyColor = makeColor('F5F5F5');

  static Color makeColor(String code) => Color(int.parse('0xFF$code'));
}
