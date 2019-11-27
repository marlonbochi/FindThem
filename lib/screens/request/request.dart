import 'package:find_them/models/client.dart';
import 'package:find_them/models/provider.dart';
import 'package:find_them/models/service.dart';
import 'package:find_them/services/clientService.dart';
import 'package:find_them/services/providerService.dart';
import 'package:find_them/services/serviceService.dart';
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
  Client client;
  final providerText = TextEditingController();
  final clientText = TextEditingController();
  final serviceText = TextEditingController();
  List<DropdownMenuItem<String>> _dropDownMenuItems;

  List<Service> services;

  void initState() {

    var clientServive = new ClientService();
    var providerService = new ProviderService();
    var serviceService = new ServiceService();

    clientServive.get(widget.token).then((responseClient){
      client = responseClient;
print(client.name);
      clientText.text = client.name;
    });

    providerService.get(widget.token, widget.providerID).then((responseProvider){
      provider = responseProvider;

      providerText.text = provider.name;
    });

    serviceService.findAll(widget.token, widget.providerID).then((responseService){
      List<Service> services = responseService;

//      providerText.text = provider.name;

      List<DropdownMenuItem<String>> items = new List();
      for (Service service in services) {
        // here we are creating the drop down menu items, you can customize the item right here
        // but I'll just use a simple text for this
        items.add(new DropdownMenuItem(
            value: service.id.toString(),
            child: new Text(service.name)
        ));
      }
      _dropDownMenuItems = items;
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
                    Text("Serviço"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: DropdownButton<String>(
                          value: "",
                          items: _dropDownMenuItems,
                          onChanged: changedDropDownItem,
                        )
                    ),
                  ],
                ),
            ),
          ),
      ),
    );
  }

  void changedDropDownItem(String selectedCity) {
    print("Selected city $selectedCity, we are going to refresh the UI");

  }
}