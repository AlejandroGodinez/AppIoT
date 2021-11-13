import 'package:app_iot/initial/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600)),
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
                        Navigator.of(context).pushNamed('/home');
                      
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
  }
}