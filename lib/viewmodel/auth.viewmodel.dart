// ignore_for_file: use_build_context_synchronously
import 'package:brilloconnetz/auth/forgot_password/forgot_password.dart';
import 'package:brilloconnetz/auth/login.dart';
import 'package:brilloconnetz/auth/verify_code.dart';
import 'package:brilloconnetz/homepage.dart';
import 'package:brilloconnetz/model/db_models.dart';
import 'package:brilloconnetz/services/auth.services.dart';
import 'package:brilloconnetz/services/user.services.dart';
import 'package:brilloconnetz/util/util.dart';
import 'package:brilloconnetz/widget/show_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final _authService = AuthService();

Future<void> login(BuildContext context, email, password) async {
  try {
    final user = await _authService.login(email, password);

    if (user != null) {
      if (user.isVerified == true) {
        await AuthService.setIsLoggedIn(true);
        await AuthService.setCurrentUserId(user.userId);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const HomePage();
            },
          ),
        );
      } else {
        showSnackBar(context, 'Please verify your account');

        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                VerifyCodeScreen(emailOrPhone: user.email!),
          ),
        );
      }

      return;
    }

    showSnackBar(context, 'Invalid Credentials');
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

Future<void> register(BuildContext context, User user) async {
  try {
    final registered = await _authService.register(user);

    if (registered) {
      //TODO: send code to mail or phone
      await showCustomDialog(context, DisplayCode(code: user.code!));

      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              VerifyCodeScreen(emailOrPhone: user.email!),
        ),
      );
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

Future<void> verifyRegistration(
  BuildContext context,
  String emailOrPhone,
  int code, [
  bool forgotPassword = false,
]) async {
  try {
    final result = await _authService.verifyRegistration(emailOrPhone, code);

    if (result == null) {
      showSnackBar(context, 'User not found');
      return;
    }

    if (result == false) {
      showSnackBar(context, 'Invalid Code');
      return;
    }

    final user = await UserService().getUser(emailOrPhone);

    await AuthService.setIsLoggedIn(true);
    await AuthService.setCurrentUserId(user?.userId);

    showSnackBar(context, 'Successfully verified code');

    if (forgotPassword) {
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ResetPasswordScreen(
            user: user,
          ),
        ),
      );

      return;
    }

    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const HomePage(),
      ),
    );
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

Future<void> updatePassword(
  BuildContext context,
  String? currentPassword,
  String newPassword, [
  User? user,
  bool resetPassword = false,
]) async {
  user ??= await UserService().getCurrentUser();

  if (!resetPassword) {
    if (user?.password != currentPassword) {
      showSnackBar(context, 'Password not match');
      return;
    }
  }

  await _authService.updatePassword(newPassword);
  showSnackBar(context, 'Password changed');

  if (resetPassword) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return const LoginScreen();
        },
      ),
    );

    return;
  }

  Navigator.pop(context);
}

Future<void> updateProfile(BuildContext context, User user) async {
  await _authService.updateProfile(user);

  showSnackBar(context, 'Details Updated');

  Navigator.pop(context);
}

Future<void> logout(BuildContext context) async {
  await _authService.logout();

  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return const LoginScreen();
    },
  ), (Route<dynamic> route) => false);
}
