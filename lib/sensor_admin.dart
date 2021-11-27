import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SensorPageAdmin extends StatefulWidget {
  final String zone;
  SensorPageAdmin({Key key, @required this.zone}) : super(key: key);

  @override
  _SensorPageAdminState createState() => _SensorPageAdminState();
}

class _SensorPageAdminState extends State<SensorPageAdmin> {
  String temperature = "";
  String co2 = "0.00";
  String humidity = "";

  Future<void> _fetchData() async {
    var url = Uri.parse(
        "https://api.thingspeak.com/channels/1560464/feeds.json?api_key=KX2RP9DUGFPJ44P4&results=2");

    while (true) {
      var res = await http.get(url);
      Map<String, dynamic> feeds = jsonDecode(res.body);
      // feeds["feeds"][0] = feeds["feeds"][1];
      Map<String, dynamic> fields = feeds["feeds"][1];

      // print("feeds:  " + feeds["feeds"][0]["field2"]);
      // if (fields["field1"] == null) {
      //   fields["field1"] = feeds["feeds"][1]["field1"];
      // } else if (fields["field2"] == null) {
      //   print("entro");
      //   fields["field2"] = feeds["feeds"][1]["field2"];
      // } else if (fields["field4"] == null) {
      //   fields["field4"] = feeds["feeds"][1]["field4"];
      // }

      print(feeds);

      // "field1":"Temperatura"
      setState(() {
        temperature = double.parse(fields["field1"]).toStringAsFixed(1);
      });
      // // "field4":"CO2"
      // setState(() {
      //   co2 = double.parse(fields["field4"]).toStringAsFixed(2);
      // });

      // "field2":"Humedad"
      setState(() {
        humidity = double.parse(fields["field2"]).toStringAsFixed(2);
      });
    }
  }

  Future<void> _writeTempEditPlus() async {
    var urlString =
        "https://api.thingspeak.com/update?api_key=EQTYHJ475FLD2ENI&field1=1";
    var urlPost = Uri.parse(urlString);
    var resPost = await http.post(urlPost);

    print(jsonDecode(resPost.body));
  }

  Future<void> _writeTempEditLess() async {
    var urlString =
        "https://api.thingspeak.com/update?api_key=EQTYHJ475FLD2ENI&field1=-1";
    var urlPost = Uri.parse(urlString);
    var resPost = await http.post(urlPost);

    print(jsonDecode(resPost.body));
  }

  Future<void> _writeCo2EditPlus() async {
    var urlString =
        "https://api.thingspeak.com/update?api_key=EQTYHJ475FLD2ENI&field2=1";
    var urlPost = Uri.parse(urlString);
    var resPost = await http.post(urlPost);

    print(jsonDecode(resPost.body));
  }

  Future<void> _writeCo2EditLess() async {
    var urlString =
        "https://api.thingspeak.com/update?api_key=EQTYHJ475FLD2ENI&field2=-1";
    var urlPost = Uri.parse(urlString);
    var resPost = await http.post(urlPost);

    print(jsonDecode(resPost.body));
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

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
                            Text("Temperature/",
                                style: TextStyle(fontSize: 32.0)),
                            Text("Humidity", style: TextStyle(fontSize: 32.0)),
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(temperature + "°C",
                                                  style: TextStyle(
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(humidity + "g/m3"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_circle_up,
                                        size: 50.0,
                                      ),
                                      onPressed: () {
                                        _writeTempEditPlus();
                                      },
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          _writeTempEditLess();
                                        },
                                        icon: Icon(
                                          Icons.arrow_circle_down,
                                          size: 50.0,
                                        ))
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(co2 + "ppm",
                                                  style: TextStyle(
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _writeCo2EditPlus();
                                      },
                                      icon: Icon(
                                        Icons.arrow_circle_up,
                                        size: 50.0,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          _writeCo2EditLess();
                                        },
                                        icon: Icon(
                                          Icons.arrow_circle_down,
                                          size: 50.0,
                                        ))
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
