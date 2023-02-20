import 'package:brilloconnetz/auth/login.dart';
import 'package:brilloconnetz/colors.dart';
import 'package:brilloconnetz/homepage.dart';
import 'package:brilloconnetz/services/auth.services.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  static const id = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: FutureBuilder<bool>(
        future: AuthService.checkIfLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return const Center(child: HomePage());
          } else {
            return const Center(child: LoginScreen());
          }
        },
      ),
      duration: 3000,
      text: 'BrilloConnetz',
      textType: TextType.TyperAnimatedText,
      textStyle: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      backgroundColor: AppColors.primaryColor,
    );
  }
}
