
import 'package:flutter/material.dart';
import 'package:my_app/src/pages/home_page.dart';
import 'package:my_app/src/pages/login_page.dart';
import 'package:my_app/src/utils/constants.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constant.APP_NAME,
      theme: ThemeData(
        primarySwatch: Constant.PRIMARY_COLOR
      ),
      home: LoginPage(),
    );
  }
}
