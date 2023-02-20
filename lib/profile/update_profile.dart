import 'package:brilloconnetz/button.dart';
import 'package:brilloconnetz/decoration.dart';
import 'package:brilloconnetz/model/db_models.dart';
import 'package:brilloconnetz/validator.dart';
import 'package:brilloconnetz/viewmodel/auth.viewmodel.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

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
            'Update Profile',
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
                  controller: emailController,
                  enableSuggestions: true,
                  validator: (val) => validateEmailField(val!.trim()),
                  decoration: inputDecoration().copyWith(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: phoneController,
                  enableSuggestions: true,
                  validator: (val) => validatePhoneField(val!.trim()),
                  decoration: inputDecoration().copyWith(
                    hintText: 'Phone Number',
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  onPressed: processChangePassword,
                  text: 'Update Profile',
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

      final user = User(
        email: emailController.text,
        phone: phoneController.text,
        updatedAt: DateTime.now(),
      );

      await updateProfile(context, user);

      setState(() => isLoading = false);
    }
  }
}
