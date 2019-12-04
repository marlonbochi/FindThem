import 'dart:convert';

import 'package:find_them/models/contact.dart';
import 'package:find_them/screens/home/home.dart';
import 'package:find_them/screens/login/login.dart';
import 'package:find_them/screens/rate/rate.dart';
import 'package:find_them/services/common.dart';
import 'package:find_them/services/requestService.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ListRequest extends StatefulWidget {

  const ListRequest({Key key}): super(key: key);

  @override
  _ListRequestState createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequest> {

  String token = "";
  String nameUser = "";
  List<Widget> listCards = new List<Widget>();

  void initState() {

    var common = new Common();

    common.testToken().then( (validated) {
      if (!validated) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        common.getPreferences("token").then((tokeResponse) {

          setState(() {
            token = tokeResponse;
          });

          var serviceRequest = new RequestService();
          List<Widget> newListCards = new List<Widget>();

          serviceRequest.findAll(token).then((requests) {

            if (requests != null) {
              requests.forEach((request) {
                newListCards.add(
                    Card(
                      child: ListTile(
                        title: Text(request.service.name),
                        onTap: () {

                          Navigator.push(context, MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                                return Rate(
                                    token: token,
                                    requestID: request.id,
                                    clientID: request.client.id,
                                    providerID: request.provider.id,
                                    providerName: request.provider.name,
                                    serviceName: request.service.name);
                              },
                              fullscreenDialog: true,
                          ));
                        },
                      ),

                    )
                );
              });

              setState(() {
                listCards = newListCards;
              });
            }
          });
        });

        common.getPreferences("nameUser").then((name){
          setState(() {
            nameUser = name;
          });
        });
      }
    });
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
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                    "Olá " + nameUser,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Procurar prestadores de serviço'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              ),
              ListTile(
                title: Text('Minhas solicitações de serviço'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListRequest()),
                  );
                },
              ),
            ],
          ), // Populate the Drawer in the next step.
        ),
        appBar: AppBar(
          title: Text("Minhas solicitações"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _logout();
              },
            )
          ],
        ),
        body: Container(
          child: Center(
            child: ListView(
                children: listCards,
            ),
          ),
        ),
      ),
    );
  }
}
