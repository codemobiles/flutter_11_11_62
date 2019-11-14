import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

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
  GoogleMapController _mapController;

  MapType _currentMapType = MapType.normal;

  final Set<Marker> _markers = {};

  final _defaultLatLng =
  CameraPosition(target: LatLng(13.7465354, 100.532752), zoom: 10);

  @override
  Widget build(BuildContext context) {
    var bannerSize = MediaQuery
        .of(context)
        .size
        .height * 0.2;

    return new Scaffold(
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(bannerSize: bannerSize),
          Container(
            color: Colors.grey,
            height: bannerSize,
          ),
          Padding(
            padding: EdgeInsets.only(top: bannerSize + 22, right: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    child: Icon(Icons.map),
                    onPressed: () {
                      setState(() {
                        _currentMapType = _currentMapType == MapType.normal
                            ? MapType.hybrid
                            : MapType.normal;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: FloatingActionButton(
                      child: Icon(Icons.pin_drop),
                      onPressed: () {
                        // database
                        setState(() {
                          addMarker(
                            position: LatLng(18.7832397, 98.9735093),
                            markerId: "aaaa",
                            isShowInfo: true,
                          );

                          animateCamera(
                              position: LatLng(18.7832397, 98.9735093));
                        });
                      },
                    ),
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.my_location),
                    onPressed: () {
                      oneTimeLocation();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void addMarker({
    @required String markerId,
    @required LatLng position,
    String title = 'none',
    String snippet = 'none',
    String pinAsset = 'assets/pin.jpeg',
    bool isShowInfo = false,
  }) {
    final ImageConfiguration imageConfiguration =
    createLocalImageConfiguration(context);

    BitmapDescriptor.fromAssetImage(imageConfiguration, pinAsset).then(
          (bitmap) =>
      {
        _markers.add(
          Marker(
            markerId: MarkerId(markerId),
            // important. unique id
            position: position,
            infoWindow: isShowInfo
                ? InfoWindow(
              title: title,
              snippet: snippet,
              onTap: () {
                _launchMaps(
                    lat: position.latitude, lng: position.longitude);
              },
            )
                : null,
            icon: bitmap,
            onTap: () {
              _launchMaps(lat: position.latitude, lng: position.longitude);
            },
          ),
        ),
      },
    );
  }

  _launchMaps({double lat, double lng}) async {
    // method 1:
//    String url = 'http://maps.google.com/?z=12&q=$lat,$lng';
//
//    if (Platform.isIOS) {
//      url = 'http://maps.apple.com/?z=12&q=$lat,$lng';
//    }
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch url';
//    }

    // method 2:

    // set info.plist
    // comgooglemaps

    String googleUrl = 'comgooglemaps://?z=12&q=$lat,$lng';
    String appleUrl = 'https://maps.apple.com/?z=12&q=$lat,$lng';
//    String googleUrl = 'comgooglemaps://?center=${lat},${lng}';
//    String appleUrl = 'https://maps.apple.com/?sll=${lat},${lng}';
    if (await canLaunch("comgooglemaps://")) {
      print('launching com googleUrl');
      await launch(googleUrl);
    } else if (await canLaunch(appleUrl)) {
      print('launching apple url');
      await launch(appleUrl);
    } else {
      throw 'Could not launch url';
    }
  }

  _buildGoogleMap({double bannerSize}) {
    return Container(
      margin: EdgeInsets.only(
        top: bannerSize,
      ),
      child: GoogleMap(
        mapType: _currentMapType,
        initialCameraPosition: _defaultLatLng,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        markers: _markers,
      ),
    );
  }

  void animateCamera({LatLng position}) {
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(position, 16));
  }



  oneTimeLocation() async {
    try {
      var currentLocation = await Location().getLocation();
      print(
          'onetime lat: ${currentLocation.latitude}, lng ${currentLocation.longitude}');
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
      print('oneTimeLocation error: ${e.message}');
    }
  }
}