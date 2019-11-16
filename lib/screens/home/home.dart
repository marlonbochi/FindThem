import 'package:find_them/services/common.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:find_them/screens/login/login.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Screen for finding services.
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String token = "";
  Completer<GoogleMapController> mapController;
  static LatLng _initialPosition;
  final Set<Marker> _markers = {};
  static  LatLng _lastMapPosition = _initialPosition;

  void initState() {
    super.initState();
    _getUserLocation();

    var common = new Common();

    common.getPreferences("token").then((response) {
      print(response);
      if (response == null || response.isEmpty){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        setState(() {
          token: response;
        });
      }
    });

  }

  void _getUserLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      print('${placemark[0].name}');
    });
  }


  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController.complete(controller);
    });
  }

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
          Marker(
              markerId: MarkerId(_lastMapPosition.toString()),
              position: _lastMapPosition,
              infoWindow: InfoWindow(
                  title: "Pizza Parlour",
                  snippet: "This is a snippet",
                  onTap: (){
                  }
              ),
              onTap: (){
              },

              icon: BitmapDescriptor.defaultMarker));
    });
  }

  Widget _buildMap() {
    if (_initialPosition == null) {
      return Container(
        child: Center(
          child: Text(
            'loading map..',
            style: TextStyle(
                fontFamily: 'Avenir-Medium', color: Colors.grey[400]
            ),
          ),
        ),
      );
    }
    return Container(
      child: Stack(children: <Widget>[
        GoogleMap(
          markers: _markers,
          mapType: _currentMapType,
          initialCameraPosition: CameraPosition(
            target: _initialPosition,
            zoom: 16.0,
          ),
          onMapCreated: _onMapCreated,
          zoomGesturesEnabled: true,
          onCameraMove: _onCameraMove,
          myLocationEnabled: true,
          compassEnabled: true,
          myLocationButtonEnabled: false,

        )
      ]),
    );
  }

  @override
    Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text("Find Them")
        ),
        body: _buildMap()
      ),
    );
  }
}
