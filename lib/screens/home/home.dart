import 'dart:math';

import 'package:find_them/models/provider.dart';
import 'package:find_them/screens/request/request.dart';
import 'package:find_them/services/common.dart';
import 'package:find_them/services/providerService.dart';
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
  final int idProvider = 0;

  void initState() {
    super.initState();
    _getUserLocation();

    var common = new Common();

    common.getPreferences("token").then((toke_response) {
      if (toke_response == null || toke_response.isEmpty){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {

        common.getPreferences("token_expiration").then((expiration_response) {
          var dateNow = new DateTime.now();
          var dateExpiration = DateTime.parse(expiration_response);

          if (dateExpiration.isBefore(dateNow)) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          } else {
            token = toke_response;

            setState(() {
              token: toke_response;
              token_expiration: expiration_response;
            });

            getProviders();
          }

        });
      }
    });

  }

  void _getUserLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
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

  void getProviders() {

    var providerService = new ProviderService();

    providerService.findAll(token).then((providers) {
      var markersProvider = convertProviderToMarkers(providers);

      setState(() {
        _markers.addAll(markersProvider);
      });
    });
  }

  convertProviderToMarkers(List<Provider> providers) {
    List<Marker> markers = new List<Marker>();

    var random = new Random();

    providers.forEach((provider) {

      if (provider.latitude != null && provider.longitude != null) {
        LatLng position = new LatLng(provider.latitude, provider.longitude);

        int next(int min, int max) => min + random.nextInt(max - min);

        var marker = Marker(
            markerId: MarkerId(next.toString()),
            position: position,
            infoWindow: InfoWindow(
                title: provider.name,
                snippet: "Clique aqui para selecionar",
                onTap: (){
                  setState(() {
                    idProvider: provider.id;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Request(token: token, providerID: provider.id)),
                  );
                }
            ),

            icon: BitmapDescriptor.defaultMarker
        );

        markers.add(marker);
      }
    });

    return markers;
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
            zoom: 14.0,
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

  void _logout() {
    var common = new Common();

    common.removePreferences("token").then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
    common.removePreferences("token_expiration");
  }

  @override
    Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text("Find Them"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  _logout();
                },
              )
            ],
        ),
        body: _buildMap(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text("Filtrar"),
          icon: Icon(Icons.search),
          backgroundColor: Colors.blue
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
      ),
    );
  }
}
