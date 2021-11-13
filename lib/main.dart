import 'package:app_iot/bloc/auth_bloc.dart';
import 'package:app_iot/initial/login.dart';
import 'package:app_iot/initial/splashscreen_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    BlocProvider(
      create: (context) => AuthBloc()..add(SplashScreenEvent()),
      child: MyApp(),
      ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState  extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          print(state);
          if (state is AlreadyAuthState) {
            // return HomePage();
            return LoginPage();
          }
          if (state is UnAuthState) {
            return LoginPage();
          }
          if (state is RegisterState) {
            // return RegisterPage();
            return LoginPage();
          }
          return SplashScreenPage();
        },
      ),
    );
  }
}