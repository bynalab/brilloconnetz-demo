import 'package:brilloconnetz/auth/forgot_password/input_email.dart';
import 'package:brilloconnetz/auth/register.dart';
import 'package:brilloconnetz/button.dart';
import 'package:brilloconnetz/colors.dart';
import 'package:brilloconnetz/decoration.dart';
import 'package:brilloconnetz/validator.dart';
import 'package:brilloconnetz/viewmodel/auth.viewmodel.dart';
import 'package:flutter/material.dart';

enum InputField { email, password }

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool hidePassword = true;
  InputField? current;

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
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0XFF1C1939),
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sign in to continue',
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
                        decoration: inputDecoration(
                          focusedBorderColor: borderColor(InputField.email),
                          enabledBorderColor: borderColor(InputField.email),
                        ).copyWith(
                          fillColor: fillColor(InputField.email),
                          hintText: 'Email or Phone',
                        ),
                        onTap: () => setCurrentField(InputField.email),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: passwordController,
                        enableSuggestions: true,
                        validator: (val) => validatePasswordField(val!.trim()),
                        obscureText: hidePassword,
                        decoration: inputDecoration(
                          focusedBorderColor: borderColor(InputField.password),
                          enabledBorderColor: borderColor(InputField.password),
                        ).copyWith(
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
                          fillColor: fillColor(InputField.password),
                          hintText: 'Password',
                        ),
                        onTap: () => setCurrentField(InputField.password),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const InputEmailForgotPasswordScreen(),
                            ),
                          ),
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        onPressed: processLogin,
                        text: 'Sign in',
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don’t have an account? - ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF4E4E4E),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const RegisterScreen(),
                        ),
                      ),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color? fillColor(InputField field) {
    if (current == field) {
      return const Color.fromRGBO(101, 178, 227, 0.2);
    }

    return null;
  }

  Color? borderColor(InputField field) {
    if (current == field) {
      return AppColors.borderColor;
    }

    return null;
  }

  void setCurrentField(InputField field) {
    setState(() => current = field);
  }

  Future<void> processLogin() async {
    if (_loginFormKey.currentState!.validate()) {
      setState(() => isLoading = true);

      await login(context, emailController.text, passwordController.text);

      setState(() => isLoading = false);
    }
  }
}
