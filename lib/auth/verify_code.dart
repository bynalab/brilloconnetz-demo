import 'package:brilloconnetz/button.dart';
import 'package:brilloconnetz/colors.dart';
import 'package:brilloconnetz/decoration.dart';
import 'package:brilloconnetz/validator.dart';
import 'package:brilloconnetz/viewmodel/auth.viewmodel.dart';
import 'package:flutter/material.dart';

enum InputField { email, password }

class VerifyCodeScreen extends StatefulWidget {
  static const id = 'verify_code_screen';

  final String emailOrPhone;
  final bool forgotPassword;

  const VerifyCodeScreen({
    Key? key,
    required this.emailOrPhone,
    this.forgotPassword = false,
  }) : super(key: key);

  @override
  VerifyCodeScreenState createState() => VerifyCodeScreenState();
}

class VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final codeController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Verify Code!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0XFF1C1939),
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Verify code sent to you',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFF4E4E4E),
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 32),
                Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: codeController,
                        enableSuggestions: true,
                        validator: (val) => validateField(val!.trim(), 'Code'),
                        decoration: inputDecoration(
                          focusedBorderColor: AppColors.borderColor,
                          enabledBorderColor: AppColors.borderColor,
                        ).copyWith(
                          fillColor: const Color.fromRGBO(101, 178, 227, 0.2),
                          hintText: 'Code',
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        onPressed: processVerifyRegistration,
                        text: 'Verify',
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> processVerifyRegistration() async {
    if (_loginFormKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      await verifyRegistration(
        context,
        widget.emailOrPhone,
        int.parse(codeController.text),
        widget.forgotPassword,
      );

      setState(() {
        isLoading = false;
      });
    }
  }
}
