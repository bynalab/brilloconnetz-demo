import 'package:brilloconnetz/colors.dart';
import 'package:brilloconnetz/profile/change_password.dart';
import 'package:brilloconnetz/profile/update_profile.dart';
import 'package:brilloconnetz/util/util.dart';
import 'package:brilloconnetz/viewmodel/auth.viewmodel.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  static const id = 'profile_page';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 38),
                CustomListTile(
                  title: 'Update Profile',
                  leading: Icon(
                    Icons.email,
                    size: 25,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () async {
                    await showCustomDialog(
                        context, const UpdateProfileScreen());
                  },
                ),
                const SizedBox(height: 10),
                CustomListTile(
                  title: 'Change Password',
                  leading: Icon(
                    Icons.password,
                    size: 25,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () async {
                    await showCustomDialog(
                        context, const ChangePasswordScreen());
                  },
                ),
                const SizedBox(height: 10),
                CustomListTile(
                  title: 'Logout',
                  leading: Icon(
                    Icons.logout,
                    size: 25,
                    color: AppColors.makeColor("FF0000"),
                  ),
                  onTap: () => logout(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final Widget leading;
  final VoidCallback? onTap;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.leading,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: AppColors.makeColor('ECF5FF'),
          borderRadius: BorderRadius.circular(5),
        ),
        child: leading,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 20,
        color: AppColors.primaryColor,
      ),
    );
  }
}
