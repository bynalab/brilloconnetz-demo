import 'package:brilloconnetz/button.dart';
import 'package:brilloconnetz/util/util.dart';
import 'package:flutter/material.dart';

class DisplayCode extends StatelessWidget {
  final int code;
  const DisplayCode({Key? key, required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Your verification code is',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            code.toString(),
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          CustomButton(
            width: 80,
            height: 35,
            padding: const EdgeInsets.symmetric(vertical: 5),
            onPressed: () => copy(context, code.toString()),
            text: 'Copy',
          ),
          const SizedBox(height: 10),
          CustomButton(
            onPressed: () => Navigator.pop(context),
            text: 'Okay',
          ),
        ],
      ),
    );
  }
}
