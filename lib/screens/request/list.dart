import 'package:find_them/screens/home/home.dart';
import 'package:find_them/screens/login/login.dart';
import 'package:find_them/services/common.dart';
import 'package:find_them/services/requestService.dart';
import 'package:flutter/material.dart';

class ListRequest extends StatefulWidget {
  final int providerID;
  final String token;

  const ListRequest({Key key, this.token, this.providerID}): super(key: key);

  @override
  _ListRequestState createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequest> {

  String token = "";
  String nameUser = "";
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

  List<Widget> mountRequests() {

    var listCards = new List<Widget>();
    var serviceRequest = new RequestService();


    serviceRequest.findAll(token).then((requests) {

      requests.forEach((request) {
        print(request);
        listCards.add(
            Card(
                child: ListTile(
                    title: Text(request.service.name),
                  onTap: () {

                  },
                ),

            )
        );
      });
    });

    return listCards;
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
        body: Container(
          child: Center(
            child: ListView(
                children: mountRequests(),
            ),
          ),
        ),
      ),
    );
  }
}