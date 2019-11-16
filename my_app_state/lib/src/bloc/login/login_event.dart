import 'package:equatable/equatable.dart';
import 'package:my_app/src/models/user.dart';



abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonClick extends LoginEvent {
  final User user;

  const LoginButtonClick({this.user});

  @override
  List<Object> get props => [user];
}