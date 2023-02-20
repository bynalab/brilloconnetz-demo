// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _snackBarDisplayDuration = Duration(milliseconds: 5000);

Future<void> copy(BuildContext context, String text) async {
  final ClipboardData word = ClipboardData(text: text);
  await Clipboard.setData(word);
  showSnackBar(context, 'Text copied to clipboard');
}

showSnackBar(BuildContext context, String message, [Duration? duration]) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: duration ?? _snackBarDisplayDuration,
    action: SnackBarAction(
      label: 'Close',
      textColor: Colors.white,
      onPressed: () {},
    ),
  );

  try {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } catch (error) {
    if (kDebugMode) {
      print('Snatch bar error: $error');
    }
  }
}

Future<void> showCustomDialog(BuildContext context, Widget content) async {
  await showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 450),
    pageBuilder: (_, __, ___) {
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: content,
              )
            ],
          ),
        ),
      );
    },
  );
}
