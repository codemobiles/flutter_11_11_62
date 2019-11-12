import 'package:flutter/material.dart';
import 'package:my_app/src/pages/home_page.dart';
import 'package:my_app/src/pages/login_page.dart';
import 'package:my_app/src/services/auth_service.dart';
import 'package:my_app/src/utils/constants.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _route = <String, WidgetBuilder>{
      Constant.HOME_ROUTE: (context) => HomePage(),
      Constant.LOGIN_ROUTE: (context) => LoginPage(),
    };
    return MaterialApp(
      title: Constant.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Constant.PRIMARY_COLOR),
      home: FutureBuilder(
          future: AuthService().isLogin(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // homework
            if (snapshot.data == false) {
              return LoginPage();
            }
            return HomePage();
          }),
      routes: _route,
    );
  }
}
