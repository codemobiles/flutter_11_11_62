import 'package:my_app/src/models/user.dart';
import 'package:my_app/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login({User user}) async {
    if(user.username == 'cm@gmail.com' && user.password == 'password'){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constant.USERNAME_PREF, user.username);
      await prefs.setBool(Constant.IS_LOGIN_PREF, true);
      return true;
    }
    return false;
  }

  Future<bool> isLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(Constant.IS_LOGIN_PREF) ?? false;
  }
}
