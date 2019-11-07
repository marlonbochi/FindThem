import 'package:find_them/services/common.dart';
import 'package:flutter/material.dart';
import 'package:find_them/screens/login/login.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Screen for finding services.
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String token = "";
  GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  void initState() {
    super.initState();
    
    var common = new Common();
    common.getPreferences("token").then((response) {
      print(response);
//      if (response.isEmpty){
//
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => Login()),
//        );
//      } else {
//        setState(() {
//          token: response;
//        });
//      }
    });

  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text("Find service provider")
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
