import 'package:flutter/material.dart';
import 'package:my_app/src/models/user.dart';
import 'package:my_app/src/utils/constants.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user = User();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.PRIMARY_COLOR,
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 22),
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
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Email',
                            icon: Icon(Icons.email),
                            labelText: 'Email'),
                        onSaved: (value) {
                          user.username = value;
                        },
                        validator: validateEmail,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Password',
                          icon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        onSaved: (value) {
                          user.password = value;
                        },
                        validator: validatePassword,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Constant.PRIMARY_COLOR,
                    textColor: Colors.white,
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        print(
                            "username: ${user.username}, password: ${user.password}");
                      }
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

  String validateEmail(String value) {
    if (!isEmail(value)) {
      return "อีเมล์ไม่ถูกต้อง";
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length < 8) {
      return "รหัสผ่านต้องมีความยาว 8 ตัวอักษร ขึ้นไป";
    }
    return null;
  }
}
