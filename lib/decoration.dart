import 'package:brilloconnetz/colors.dart';
import 'package:flutter/material.dart';

InputDecoration inputDecoration(
        {Color? focusedBorderColor, Color? enabledBorderColor}) =>
    InputDecoration(
      isDense: true,
      fillColor: AppColors.greyColor,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(32, 13, 0, 12),
      counterText: '',
      hintStyle: TextStyle(
        color: AppColors.makeColor('9CA3AF'),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: focusedBorderColor ?? AppColors.primaryColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: enabledBorderColor ?? AppColors.primaryColor,
          width: 1.5,
        ),
      ),
    );
