import 'package:brilloconnetz/button.dart';
import 'package:brilloconnetz/decoration.dart';
import 'package:brilloconnetz/model/db_models.dart';
import 'package:brilloconnetz/validator.dart';
import 'package:brilloconnetz/viewmodel/auth.viewmodel.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const id = 'forgot_password_screen';

  final User? user;

  const ResetPasswordScreen({Key? key, this.user}) : super(key: key);

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool hidePassword = true;

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
                Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      const Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Color(0XFF1C1939),
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        enableSuggestions: true,
                        validator: (val) => validatePasswordField(val!.trim()),
                        obscureText: hidePassword,
                        decoration: inputDecoration().copyWith(
                          suffixIcon: GestureDetector(
                            child: Icon(
                              Icons.remove_red_eye,
                              color: hidePassword
                                  ? const Color(0XFF000000)
                                  : const Color(0XFF000000).withOpacity(0.4),
                            ),
                            onTap: () =>
                                setState(() => hidePassword = !hidePassword),
                          ),
                          hintText: 'Enter New Password',
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        onPressed: resetPassword,
                        text: 'Reset Password',
                        isLoading: isLoading,
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

  Future<void> resetPassword() async {
    if (_loginFormKey.currentState!.validate()) {
      setState(() => isLoading = true);

      await updatePassword(
          context, null, passwordController.text, widget.user, true);

      setState(() => isLoading = false);
    }
  }
}
