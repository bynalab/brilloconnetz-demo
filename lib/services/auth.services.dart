// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:math';
import 'package:brilloconnetz/model/db_models.dart';
import 'package:brilloconnetz/services/storage.services.dart';
import 'package:brilloconnetz/services/user.services.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';

class AuthService {
  static const loginKey = 'is_loggedIn';
  static const userIdKey = 'user_id';

  static Future<void> setIsLoggedIn(bool isLoggedIn) async {
    await StorageService.writeToGetStorage(loginKey, isLoggedIn);
  }

  static Future<void> setCurrentUserId(String? userId) async {
    await StorageService.writeToGetStorage(userIdKey, userId);
  }

  static Future<void> unsetCurrentUserId() async {
    await StorageService.removeFromGetStorage(userIdKey);
  }

  static Future<String?> getCurrentUserId() async {
    return await StorageService.readFromGetStorage(userIdKey);
  }

  static Future<bool> checkIfLoggedIn() async {
    final loggedIn = await StorageService.readFromGetStorage(loginKey);
    final userId = await getCurrentUserId();

    return loggedIn == true && userId != null;
  }

  Future<User?> login(String login, String password) async {
    final md5Password = generateMd5(password);

    final user = await User()
        .select()
        .email
        .equals(login)
        .and
        .password
        .equals(md5Password)
        .or
        .phone
        .equals(login)
        .and
        .password
        .equals(md5Password)
        .toSingle();

    return user;
  }

  int generate5Digit() {
    var rng = Random();
    var code = rng.nextInt(90000) + 10000;

    return code;
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<bool> register(User user) async {
    final userId = const Uuid().v1();

    user.userId = userId;

    user.password = generateMd5(user.password!);
    user.createdAt = DateTime.now();

    final register = await user.save();

    return register.success;
  }

  Future<bool?> verifyRegistration(String emailOrPhone, int code) async {
    final user = await UserService().getUser(emailOrPhone);

    if (user == null) {
      return null;
    }

    if (user.code != code) {
      return false;
    }

    user.isVerified = true;

    final verify = await user.save();

    return verify.success;
  }

  Future<void> logout() async {
    await setIsLoggedIn(false);
    await unsetCurrentUserId();
  }

  Future<bool> updatePassword(String password) async {
    final userId = await AuthService.getCurrentUserId();

    final register = await User()
        .select()
        .userId
        .equals(userId)
        .update({'password': password});

    return register.success;
  }

  Future<bool> updateProfile(User user) async {
    final userId = await AuthService.getCurrentUserId();

    final register = await User().select().userId.equals(userId).update(
      {
        'email': user.email,
        'phone': user.phone,
        'updatedAt': DateTime.now().toString(),
      },
    );

    return register.success;
  }

  Future requestPasswordResetCode(String email) async {}
}
