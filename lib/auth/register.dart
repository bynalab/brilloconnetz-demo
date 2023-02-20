import 'package:brilloconnetz/auth/login.dart';
import 'package:brilloconnetz/button.dart';
import 'package:brilloconnetz/colors.dart';
import 'package:brilloconnetz/decoration.dart';
import 'package:brilloconnetz/model/db_models.dart';
import 'package:brilloconnetz/services/auth.services.dart';
import 'package:brilloconnetz/validator.dart';
import 'package:brilloconnetz/viewmodel/auth.viewmodel.dart';
import 'package:flutter/material.dart';

enum InputField { phoneNumber, email, password, interest }

class RegisterScreen extends StatefulWidget {
  static const id = 'register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final interestController = TextEditingController();

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
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0XFF1C1939),
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Please provide following details for your new account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFF4E4E4E),
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 32),
                Form(
                  key: _registerFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        enableSuggestions: true,
                        validator: (val) => validateEmailField(val!.trim()),
                        decoration: inputDecoration(
                          focusedBorderColor: borderColor(InputField.email),
                          enabledBorderColor: borderColor(InputField.email),
                        ).copyWith(
                          fillColor: fillColor(InputField.email),
                          hintText: 'Email',
                        ),
                        onTap: () => setCurrentField(InputField.email),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: phoneNumberController,
                        enableSuggestions: true,
                        validator: (val) => validatePhoneField(val!.trim()),
                        decoration: inputDecoration(
                          focusedBorderColor:
                              borderColor(InputField.phoneNumber),
                          enabledBorderColor:
                              borderColor(InputField.phoneNumber),
                        ).copyWith(
                          fillColor: fillColor(InputField.phoneNumber),
                          hintText: 'Phone Number',
                        ),
                        onTap: () => setCurrentField(InputField.phoneNumber),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: interestController,
                        maxLines: 3,
                        validator: (val) =>
                            validateField(val!.trim(), 'Interest'),
                        decoration: inputDecoration(
                          focusedBorderColor: borderColor(InputField.interest),
                          enabledBorderColor: borderColor(InputField.interest),
                        ).copyWith(
                          fillColor: fillColor(InputField.interest),
                          hintText:
                              'Interests... e.g Football, Basketball \n\nPlease separate with comma(,)',
                          hintStyle: const TextStyle(fontSize: 15),
                        ),
                        onTap: () => setCurrentField(InputField.interest),
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
                      const SizedBox(height: 40),
                      CustomButton(
                        onPressed: processRegistration,
                        text: 'Sign up',
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
                      "Already have an account? - ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF4E4E4E),
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const LoginScreen(),
                        ),
                      ),

                      // Navigator.pushNamed(context, LoginScreen.id),
                      // onTap: () => namedNavigateTo(LoginScreen.id),
                      child: Text(
                        'Sign in',
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
      return const Color(0XFF65B2E3);
    }

    return null;
  }

  void setCurrentField(InputField field) => setState(() => current = field);

  Future<void> processRegistration() async {
    if (_registerFormKey.currentState!.validate()) {
      setState(() => isLoading = true);

      final user = User(
        email: emailController.text,
        phone: phoneNumberController.text,
        password: passwordController.text,
        interests: interestController.text,
        code: AuthService().generate5Digit(),
      );

      await register(context, user);

      setState(() => isLoading = false);
    }
  }
}
