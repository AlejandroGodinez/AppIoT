import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SensorPageUser extends StatefulWidget {
  final String zone;
  SensorPageUser({Key key, @required this.zone}) : super(key: key);

  @override
  _SensorPageUserState createState() => _SensorPageUserState();
}

class _SensorPageUserState extends State<SensorPageUser> {
  String temperature = "";
  String co2 = "";
  String humidity = "";

  Future<void> _fetchData() async {
    var url = Uri.parse(
        "https://api.thingspeak.com/channels/1560464/feeds.json?api_key=KX2RP9DUGFPJ44P4&results=2");

    while (true) {
      var res = await http.get(url);
      Map<String, dynamic> feeds = jsonDecode(res.body);
      Map<String, dynamic> fields = feeds["feeds"][0];
      print(fields["field1"]);
      // "field1":"Temperatura"
      setState(() {
        temperature = double.parse(fields["field1"]).toStringAsFixed(1);
      });
      // "field4":"CO2"
      setState(() {
        co2 = double.parse(fields["field4"]).toStringAsFixed(2);
      });

      // "field2":"Humedad"
      setState(() {
        humidity = double.parse(fields["field2"]).toStringAsFixed(2);
      });
    }
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
              'IOTESO User',
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
                                  "Here you will be able to see the Temperature and CO2 levels of your area of choice"),
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
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Text("Temperature/", style: TextStyle(fontSize: 32.0)),
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(temperature+"°C", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(humidity+"g/m3"),
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
                                  Icon(
                                    Icons.ac_unit,
                                    size: 100.0,
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
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Text("CO2 Levels", style: TextStyle(fontSize: 32.0)),
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(co2+"ppm", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
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
                                  Icon(
                                    Icons.air,
                                    size: 100.0,
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
      ),
    );
  }
}
