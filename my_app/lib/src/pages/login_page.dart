import 'package:flutter/material.dart';
import 'package:my_app/src/utils/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.PRIMARY_COLOR,
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  Constant.BANNER,
                  width: 200,
                ),
                SizedBox(height: 22),
                Text("Login Page"),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      //todo
                    },
                    child: Text("Login"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {
                      // todo
                    },
                    child: Text("Register"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
