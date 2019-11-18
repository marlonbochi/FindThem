import 'package:find_them/models/provider.dart';
import 'package:find_them/models/service.dart';
import 'package:find_them/services/providerService.dart';
import 'package:flutter/material.dart';

class Request extends StatefulWidget {
  final int providerID;
  final String token;

  const Request({Key key, this.token, this.providerID}): super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {

  Provider provider;
  final providerText = TextEditingController();
  final clientText = TextEditingController();

  List<Service> services;

  void initState() {

    var providerServive = new ProviderService();

    providerServive.get(widget.token, widget.providerID).then((responseProvider){
      provider = responseProvider;

      providerText.text = provider.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Solicitar serviço"),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            ),
        ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text("Cliente")
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: clientText,enabled: false),
                    ),
                    Text("Prestador de serviço"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: providerText, enabled: false),
                    ),
                  ],
                ),
            ),
          ),
      ),
    );
  }
}