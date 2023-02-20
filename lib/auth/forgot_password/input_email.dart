// ignore_for_file: use_build_context_synchronously

import 'package:brilloconnetz/auth/verify_code.dart';
import 'package:brilloconnetz/button.dart';
import 'package:brilloconnetz/decoration.dart';
import 'package:brilloconnetz/services/auth.services.dart';
import 'package:brilloconnetz/services/user.services.dart';
import 'package:brilloconnetz/util/util.dart';
import 'package:brilloconnetz/validator.dart';
import 'package:brilloconnetz/widget/show_code.dart';
import 'package:flutter/material.dart';

class InputEmailForgotPasswordScreen extends StatefulWidget {
  static const id = 'forgot_password_screen';

  const InputEmailForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  InputEmailForgotPasswordScreenState createState() =>
      InputEmailForgotPasswordScreenState();
}

class InputEmailForgotPasswordScreenState
    extends State<InputEmailForgotPasswordScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

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
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0XFF1C1939),
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enter your email address or phone number',
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
                        controller: emailController,
                        enableSuggestions: true,
                        validator: (val) => validateEmailOrPhone(val!.trim()),
                        decoration: inputDecoration()
                            .copyWith(hintText: 'Email or Phone'),
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        onPressed: gotoVerificationScreen,
                        text: 'Next',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> gotoVerificationScreen() async {
    if (_loginFormKey.currentState!.validate()) {
      final user = await UserService().getUser(emailController.text);

      if (user == null) {
        showSnackBar(context, 'Invalid Credential');
        return;
      }

      final code = AuthService().generate5Digit();
      user.code = code;
      await user.save();

      //TODO: send code to mail or phone
      await showCustomDialog(context, DisplayCode(code: code));

      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return VerifyCodeScreen(
              emailOrPhone: emailController.text,
              forgotPassword: true,
            );
          },
        ),
      );
    }
  }
}
