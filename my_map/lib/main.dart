import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.grey,
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 170.0, right: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      FloatingActionButton(
                        child: Icon(Icons.map),
                        onPressed: (){},
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: FloatingActionButton(
                          child: Icon(Icons.map),
                          onPressed: (){},
                        ),
                      ),
                      FloatingActionButton(
                        child: Icon(Icons.my_location),
                        onPressed: (){},
                      )
                    ],
                  ),
                ),
              )

            ],
          ),
        ],
      ),
    );
  }
}
