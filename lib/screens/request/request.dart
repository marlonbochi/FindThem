import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:find_them/models/client.dart';
import 'package:find_them/models/provider.dart';
import 'package:find_them/models/request.dart' as models;
import 'package:find_them/models/service.dart';
import 'package:find_them/screens/login/login.dart';
import 'package:find_them/screens/request/list.dart';
import 'package:find_them/services/api.dart';
import 'package:find_them/services/clientService.dart';
import 'package:find_them/services/common.dart';
import 'package:find_them/services/providerService.dart';
import 'package:find_them/services/requestService.dart';
import 'package:find_them/services/serviceService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final dateStartController = TextEditingController();
  final dateEndController = TextEditingController();
  final descriptionController = TextEditingController();
  final cepController = TextEditingController();
  final addressController = TextEditingController();
  final numberAddressController = TextEditingController();
  final complementAddressController = TextEditingController();
  final neighborhoodAddressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  final format = DateFormat("yyyy-MM-dd HH:mm:ss");


  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<Service> services;
  Service selectedService;

  String _currentService;

  void initState() {

    var clientServive = new ClientService();
    var providerService = new ProviderService();
    var serviceService = new ServiceService();

    var common = new Common();

    common.testToken().then( (validated) {

      if (!validated) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    });

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
      valueController.text = selectedService.price.toString();
    }
  }

  void getInformationCEP(String cep) {
    var api = new API();

    if (cep.length > 7){
        api.getInformationCEP(cepController.text).then((address) {
          addressController.text = address["logradouro"];
          neighborhoodAddressController.text = address["bairro"];
          cityController.text = address["localidade"];
          stateController.text = address["uf"];
        });
    }
  }

  void createRequest() {

    var request = new models.Request(
        0,
        client,
        provider,
        selectedService,
        DateTime.parse(dateStartController.text),
        DateTime.parse(dateEndController.text),
        descriptionController.text,
        int.parse(cepController.text),
        addressController.text,
        numberAddressController.text,
        complementAddressController.text,
        neighborhoodAddressController.text,
        stateController.text,
        cityController.text, 0, 0, "A",
        double.parse(valueController.text),
        true);

    var serviceRequest = new RequestService();

    serviceRequest.create(widget.token, request).then((saved) {

      if (saved) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListRequest()),
        );
      }
    });

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
                    Text("Valor:"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: valueController, enabled: false),
                    ),
                    Text("Data Inicio:"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: DateTimeField(
                        controller: dateStartController,
                        format: format,
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime:
                              TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        },
                      ),
                    ),
                    Text("Data final:"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: DateTimeField(
                        controller: dateEndController,
                        format: format,
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime:
                              TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        },
                      ),
                    ),
                    Text("Description:"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: descriptionController, enabled: true, keyboardType: TextInputType.multiline, maxLines: null),
                    ),
                    Text("CEP:"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: cepController, maxLength: 8, enabled: true, keyboardType: TextInputType.number, onChanged: (cep){getInformationCEP(cep);}),
                    ),
                    Text("Endereço:"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: addressController, enabled: false),
                    ),
                    Text("Número:"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: numberAddressController, enabled: true, keyboardType: TextInputType.number),
                    ),
                    Text("Complemento:"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: complementAddressController, enabled: true),
                    ),
                    Text("Bairro:"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: neighborhoodAddressController, enabled: true),
                    ),
                    Text("Cidade:"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: cityController, enabled: false),
                    ),
                    Text("Estado:"),
                    Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: TextField(controller: stateController, enabled: false),
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