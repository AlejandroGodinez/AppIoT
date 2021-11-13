import 'package:app_iot/bloc/auth_bloc.dart';
import 'package:app_iot/initial/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool hidePswd1 = true;
  bool hidePswd2 = true;

  LoginBloc _loginBloc = LoginBloc();

  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();

  void _emailRegister(bool _) {
    _loginBloc.add(RegisterEvent(
        email: email.text, password: password.text, name: email.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginBloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("Could not register"),
                  content: Text(
                    state.error,
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    MaterialButton(
                      color: Colors.blue.shade900,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    )
                  ],
                );
              },
            );
          } else if (state is RegisterSuccessState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("Success! User registered"),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state is LoginSuccessState) {
            BlocProvider.of<AuthBloc>(context).add(VerifyAuthenticationEvent());
          }
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(ShowLoginEvent());
                },
              ),
              title: Text(
                'IOTESO',
                style: TextStyle(fontSize: 30.0),
              ),
              backgroundColor: Color.fromARGB(255, 0, 70, 127),
              centerTitle: true,
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Text("Register your data",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: email,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: password,
                          obscureText: hidePswd1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              iconSize: 25,
                              icon: (hidePswd1
                                  ? Icon(
                                      Icons.visibility_off_outlined,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.grey,
                                    )),
                              onPressed: () {
                                setState(() {
                                  hidePswd1 = !hidePswd1;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: confirmPassword,
                          obscureText: hidePswd2,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              iconSize: 25,
                              icon: (hidePswd2
                                  ? Icon(
                                      Icons.visibility_off_outlined,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.grey,
                                    )),
                              onPressed: () {
                                setState(() {
                                  hidePswd2 = !hidePswd2;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Create Account',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.of(context).pushNamed('/home');
                          if (password.text == confirmPassword.text) {
                            _emailRegister(true);
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text("Could not register"),
                                  content: Text(
                                    "Passwords do not match",
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    MaterialButton(
                                      color: Colors.blue.shade900,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK"),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
