import 'package:brilloconnetz/button.dart';
import 'package:brilloconnetz/decoration.dart';
import 'package:brilloconnetz/validator.dart';
import 'package:brilloconnetz/viewmodel/auth.viewmodel.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  bool hideCurrentPassword = true;
  bool hideNewPassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              child: const Icon(Icons.close),
              onTap: () => Navigator.pop(context),
            ),
          ),
          const Text(
            'Change Password',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: currentPasswordController,
                  enableSuggestions: true,
                  validator: (val) =>
                      validatePasswordField(val!.trim(), 'Current Password'),
                  obscureText: hideCurrentPassword,
                  decoration: inputDecoration().copyWith(
                    suffixIcon: GestureDetector(
                      child: Icon(
                        Icons.remove_red_eye,
                        color: hideCurrentPassword
                            ? const Color(0XFF000000)
                            : const Color(0XFF000000).withOpacity(0.4),
                      ),
                      onTap: () => setState(
                          () => hideCurrentPassword = !hideCurrentPassword),
                    ),
                    hintText: 'Current Password',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: newPasswordController,
                  enableSuggestions: true,
                  validator: (val) =>
                      validatePasswordField(val!.trim(), 'New Password'),
                  obscureText: hideNewPassword,
                  decoration: inputDecoration().copyWith(
                    suffixIcon: GestureDetector(
                      child: Icon(
                        Icons.remove_red_eye,
                        color: hideNewPassword
                            ? const Color(0XFF000000)
                            : const Color(0XFF000000).withOpacity(0.4),
                      ),
                      onTap: () =>
                          setState(() => hideNewPassword = !hideNewPassword),
                    ),
                    hintText: 'New Password',
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  onPressed: processChangePassword,
                  text: 'Update Password',
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> processChangePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      await updatePassword(
        context,
        currentPasswordController.text,
        newPasswordController.text,
      );

      setState(() => isLoading = false);
    }
  }
}
