import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/src/bloc/authen/authen_bloc.dart';
import 'package:my_app/src/bloc/authen/authen_state.dart';
import 'package:my_app/src/pages/index.dart';
import 'package:my_app/src/utils/constants.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var _route = <String, WidgetBuilder>{
      Constant.HOME_ROUTE: (context) => HomePage(),
      Constant.LOGIN_ROUTE: (context) => LoginPage(),
      Constant.FAVORITE_ROUTE: (context) => FavoritePage(),
    };
    return MaterialApp(
      title: Constant.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Constant.PRIMARY_COLOR),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnauthenticated) {
            return LoginPage();
          }

          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }

          if (state is AuthenticationLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            color: Colors.red,
          );
        },
      ),

//      home: FutureBuilder(
//          future: AuthService().isLogin(),
//          builder: (BuildContext context, AsyncSnapshot snapshot) {
//            // homework
//            if (snapshot.data == false) {
//              return LoginPage();
//            }
//            return HomePage();
//          }),
      routes: _route,
    );
  }
}
