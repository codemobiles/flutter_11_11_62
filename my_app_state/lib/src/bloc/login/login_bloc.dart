import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:my_app/src/bloc/authen/bloc.dart';
import 'package:my_app/src/models/user.dart';
import 'package:my_app/src/services/auth_service.dart';
import 'package:validators/validators.dart';

import 'bloc.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authenticationBloc,
  });


  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonClick) {
     yield* _mapLoginButtonClickToState(event);
    }
  }

   // m : 1, l: 5, xl: 5


  Stream<LoginState> _mapLoginButtonClickToState(LoginButtonClick event) async* {
    try {
      String errorUsername;
      String errorPassword;

      if (event.user.username.isEmpty) {
        errorUsername = 'The Email is Empty';
      } else if (!isEmail(event.user.username)) {
        errorUsername = 'The Email must be a valid email.';
      }

      if (event.user.password.length < 8) {
        errorPassword = 'The Password must be at least 8 charactors.';
      }

      if (errorUsername == null && errorPassword == null) {


        final success = await AuthService().login(user: event.user);

        if(!success){
          yield LoginFailure(error: "Username or Password incorrect");
        }else{
          authenticationBloc.add(LoggedIn());
        }

        yield InitialLoginState();
      } else {
        yield FormInValid(
            errorUsername: errorUsername, errorPassword: errorPassword);
      }
    } catch (ex) {
      yield LoginFailure(error: ex);
    }
  }
}
