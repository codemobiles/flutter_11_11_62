import 'package:flutter/material.dart';
import 'package:my_app/src/models/user.dart';
import 'package:my_app/src/services/auth_service.dart';
import 'package:my_app/src/utils/constants.dart';
import 'package:my_app/src/widgets/white_space.dart';
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
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 22),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  buildImage(),
                  WhiteSpaceWidget(),
                  buildForm(),
                  SizedBox(height: 18),
                  buildLoginButton(),
                  buildRegisterButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: FlatButton(
        onPressed: () {
          // todo
        },
        child: Text("Register"),
      ),
    );
  }

  SizedBox buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Constant.PRIMARY_COLOR,
        textColor: Colors.white,
        onPressed: () async {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            print("username: ${user.username}, password: ${user.password}");

            final isSuccess = await AuthService().login(user: user); // async
            print(isSuccess);
            if (isSuccess == true) {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => HomePage()),
//              );

              Navigator.pushReplacementNamed(context, Constant.HOME_ROUTE);
            } else {
              showAlertDialog();
            }
          }
        },
        child: Text("Login"),
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Email', icon: Icon(Icons.email), labelText: 'Email'),
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
    );
  }

  Image buildImage() {
    return Image.asset(
      Constant.BANNER,
      width: 200,
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

  void showAlertDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Login Fail'),
          content: Text('username or password'),
          actions: <Widget>[
            FlatButton(
              child: Text('try again'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}
