import 'package:brilloconnetz/model/db_models.dart';
import 'package:brilloconnetz/services/auth.services.dart';

class UserService {
  Future<User?> getCurrentUser() async {
    final userId = await AuthService.getCurrentUserId();

    final user = await User().select().userId.equals(userId).toSingle();

    return user;
  }

  Future<User?> getUser(String emailOrPhone) async {
    final user = await User()
        .select()
        .email
        .equals(emailOrPhone)
        .or
        .phone
        .equals(emailOrPhone)
        .toSingle();

    return user;
  }
}
