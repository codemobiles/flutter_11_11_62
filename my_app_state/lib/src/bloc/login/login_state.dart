import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitialLoginState extends LoginState {}

class FormInValid extends LoginState {
  final String errorUsername;
  final String errorPassword;

  const FormInValid({this.errorUsername, this.errorPassword});

  @override
  List<Object> get props => [errorUsername, errorPassword];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({this.error});

  @override
  List<Object> get props => [error];
}
