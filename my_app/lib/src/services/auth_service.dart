import 'package:my_app/src/models/user.dart';
import 'package:my_app/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
  Future<void> login({User user}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constant.USERNAME_PREF, user.username);
  }
}