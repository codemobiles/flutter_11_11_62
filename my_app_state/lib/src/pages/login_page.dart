import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/src/bloc/authen/bloc.dart';
import 'package:my_app/src/bloc/login/bloc.dart';
import 'package:my_app/src/models/user.dart';
import 'package:my_app/src/utils/constants.dart';
import 'package:my_app/src/widgets/white_space.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.PRIMARY_COLOR,
      body: BlocProvider<LoginBloc>(
        builder: (context) => LoginBloc(authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 22),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state){
                    if(state is LoginFailure){
                      showAlertDialog();
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state){
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          buildImage(),
                          WhiteSpaceWidget(),
                          _buildForm(state),
                          SizedBox(height: 18),
                          buildLoginButton(context),
                          buildRegisterButton()
                        ],
                      );
                    },
                  ),
                ),
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

  SizedBox buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Constant.PRIMARY_COLOR,
        textColor: Colors.white,
        onPressed: () async {
////          if (_formKey.currentState.validate()) {
////            _formKey.currentState.save();
////            print("username: ${user.username}, password: ${user.password}");
////
////            final isSuccess = await AuthService().login(user: user); // async
////            print(isSuccess);
////            if (isSuccess == true) {
//////              Navigator.push(
//////                context,
//////                MaterialPageRoute(builder: (context) => HomePage()),
//////              );
////
////              Navigator.pushReplacementNamed(context, Constant.HOME_ROUTE);
////            } else {
////              showAlertDialog();
////            }
//          }
          final user = User();
          user.username = _usernameController.text;
          user.password = _passwordController.text;
          BlocProvider.of<LoginBloc>(context).add(LoginButtonClick(user: user));
        },
        child: Text("Login"),
      ),
    );
  }

  Image buildImage() {
    return Image.asset(
      Constant.BANNER,
      width: 200,
    );
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

  _buildForm(state) => Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Email',
                icon: Icon(Icons.email),
                labelText: 'Email',
                errorText: state is FormInValid ? state.errorUsername : null,
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Password',
                icon: Icon(Icons.lock),
                errorText: state is FormInValid ? state.errorPassword : null,
              ),
              obscureText: true,
            ),
          ],
        ),
      );
}
