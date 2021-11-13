import 'package:flutter/material.dart';

class SensorPageAdmin extends StatefulWidget {
  final String zone;
  SensorPageAdmin({Key key, @required this.zone}) : super(key: key);

  @override
  _SensorPageAdminState createState() => _SensorPageAdminState();
}

class _SensorPageAdminState extends State<SensorPageAdmin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                'IOTESO ADMIN',
                style: TextStyle(fontSize: 30.0),
              ),
              backgroundColor: Color.fromARGB(255, 0, 70, 127),
              centerTitle: true,
              actions: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(Icons.help_outline_outlined),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text(
                                    "Here you will be able to see and update as Admin the Temperature and CO2 levels of your area of choice"),
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
                            });
                      },
                    ))
              ]),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.zone,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Text("Temperature",
                                style: TextStyle(fontSize: 32.0)),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2),
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              begin: Alignment(0, -1),
                                              end: Alignment(1, 1),
                                              colors: [
                                                Colors.white,
                                                Colors.grey.shade400,
                                              ])),
                                      child: Text(""),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.arrow_circle_up,
                                      size: 50.0,
                                    ),
                                    Icon(
                                      Icons.arrow_circle_down,
                                      size: 50.0,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Text("CO2 Levels",
                                style: TextStyle(fontSize: 32.0)),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2),
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              begin: Alignment(0, -1),
                                              end: Alignment(1, 1),
                                              colors: [
                                                Colors.white,
                                                Colors.grey.shade400,
                                              ])),
                                      child: Text(""),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.arrow_circle_up,
                                      size: 50.0,
                                    ),
                                    Icon(
                                      Icons.arrow_circle_down,
                                      size: 50.0,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
