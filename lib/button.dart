// ignore_for_file: avoid_returning_null_for_void

import 'package:brilloconnetz/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final EdgeInsets? padding;

  const CustomButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
    required this.text,
    this.textStyle,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? () => null : onPressed,
      child: Container(
        width: width ?? 366,
        height: height,
        padding: padding ?? const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: backgroundColor ?? AppColors.primaryColor,
        ),
        child: isLoading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.all(5),
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            : Text(
                text,
                textAlign: TextAlign.center,
                style: textStyle ??
                    TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: textColor ?? const Color(0XFFFFFFFF),
                      fontFamily: 'Montserrat',
                    ),
              ),
      ),
    );
  }
}
