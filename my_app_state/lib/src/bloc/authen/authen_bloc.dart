import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_app/src/services/auth_service.dart';

import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield AuthenticationLoading();
      await Future.delayed(Duration(seconds: 2));

      final isLogin = await AuthService().isLogin();
      if (isLogin == true) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await Future.delayed(Duration(seconds: 2));
      yield AuthenticationUnauthenticated();
    }
  }
}
