import 'package:app_iot/bloc/auth_bloc.dart';
import 'package:app_iot/sensor_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              'IOTESO ADMIN',
              style: TextStyle(fontSize: 30.0),
            ),
            backgroundColor: Color.fromARGB(255, 0, 70, 127),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: TextButton.styleFrom(backgroundColor: Colors.grey),
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context)
                          .add(SignOutAuthenticationEvent());
                    }),
              )
            ],
          ),
          body: SingleChildScrollView(
              child: Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Select the area you want to sense",
                        style: TextStyle(fontSize: 20.0),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              icon: Icon(Icons.print),
                              iconSize: 64.0,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SensorPageAdmin(zone: "Office",)));
                              }),
                          Text("Office")
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 64.0,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              icon: Icon(Icons.restaurant),
                              iconSize: 64.0,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SensorPageAdmin(zone: "Dinning Room")));
                              }),
                          Text("Dining Room")
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              icon: Icon(Icons.ring_volume),
                              iconSize: 64.0,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SensorPageAdmin(zone: "Reception")));
                              }),
                          Text("Reception")
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 64.0,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              icon: Icon(Icons.room),
                              iconSize: 64.0,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SensorPageAdmin(zone: "Conference Room")));
                              }),
                          Text("Conference"),
                          Text("Room")
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              icon: Icon(Icons.videogame_asset),
                              iconSize: 64.0,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SensorPageAdmin(zone: "Rest Area")));
                              }),
                          Text("Rest Area")
                        ],
                      )
                    ],
                  ),
                ],
              ))
            ],
          ))),
    );
  }
}
