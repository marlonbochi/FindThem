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
  final valueController = TextEditingController();
  final materialsController = TextEditingController();
  final descriptionController = TextEditingController();


  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<Service> services;
  Service selectedService;

  String _currentService;

  void initState() {

    var clientServive = new ClientService();
    var providerService = new ProviderService();
    var serviceService = new ServiceService();

    clientServive.get(widget.token).then((responseClient){
      client = responseClient;
      clientText.text = client.user.name;
    });

    providerService.get(widget.token, widget.providerID).then((responseProvider){
      provider = responseProvider;

      providerText.text = provider.name;
    });

    serviceService.findAll(widget.token, widget.providerID).then((responseService){
      services = responseService;

//      providerText.text = provider.name;

      List<DropdownMenuItem<String>> items = new List();

      items.add(new DropdownMenuItem(
          value: "",
          child: new Text("Selecione o serviço")
      ));

      for (Service service in services) {
        // here we are creating the drop down menu items, you can customize the item right here
        // but I'll just use a simple text for this
        items.add(new DropdownMenuItem(
            value: service.id.toString(),
            child: new Text(service.name)
        ));
      }

      setState(() {
        _dropDownMenuItems = items.toList();
        _currentService = _dropDownMenuItems[0].value;
      });
    });
  }

  void changedDropDownItem(String optionSelected) {

    if (optionSelected != "") {
      for (Service service in services) {
        if (service.id.toString() == optionSelected) selectedService = service;
      }

      setState(() {
        _currentService = optionSelected;
      });

      descriptionController.text = selectedService.description;
      materialsController.text = selectedService.materials;
      valueController.text = 'R\$ ' + selectedService.price.toString().replaceAll(".", ",");
    }
  }

  void createRequest() {

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text("Solicitar serviço"),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            ),
        ),
          body: SingleChildScrollView(
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
                      child: TextField(controller: clientText,enabled: false, keyboardType: TextInputType.multiline, maxLines: null),
                    ),
                    Text("Prestador de serviço"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: providerText, enabled: false, keyboardType: TextInputType.multiline, maxLines: null),
                    ),
                    Text("Serviço"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: DropdownButton<String>(
                          value: _currentService,
                          items: _dropDownMenuItems,
                          onChanged: changedDropDownItem,
                          isExpanded: true,
                        ),
                    ),
                    Text("Descrição:"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: descriptionController, enabled: false, keyboardType: TextInputType.multiline, maxLines: null),
                    ),
                    Text("Materiais:"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: materialsController, enabled: false, keyboardType: TextInputType.multiline, maxLines: null),
                    ),
                    Text("Valor:"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: valueController, enabled: false),
                    ),
                    Container(
                      margin: new EdgeInsets.only(top: 25),
                      child: Center(
                        child: ButtonTheme(
                          height: 40.0,
                          child: RaisedButton(
                              onPressed: createRequest,
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                              child: Text(
                                "Criar requisição",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                              color:Colors.blue,
                          ),
                        ),
                       ),
                    ),
                  ],
                ),
            ),
          ),
      ),
    );
  }
}