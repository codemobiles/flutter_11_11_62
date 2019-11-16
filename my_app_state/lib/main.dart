
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/src/bloc/FlowBloc.dart';
import 'package:my_app/src/bloc/authen/authen_bloc.dart';
import 'package:my_app/src/bloc/authen/authen_event.dart';
import 'package:my_app/src/my_app.dart';

import 'package:bloc/bloc.dart';

void main() {
  BlocSupervisor.delegate = FlowBlocDelegate();
  return runApp(
    BlocProvider<AuthenticationBloc>(
      builder: (context) => AuthenticationBloc()..add(AppStarted()),
      child: MyApp(),
    ),
  );
}
