import 'package:find_them/screens/home/home.dart';
import 'package:find_them/services/clientService.dart';
import 'package:flutter/material.dart';
import 'package:find_them/services/api.dart';
import 'package:find_them/services/common.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final emailTextField = TextEditingController();
  final passwordTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
              padding: new EdgeInsets.only(bottom: 25.0),
                child: new Image(image: AssetImage('assets/icon.png'), alignment: Alignment.center, width: 100, height: 100 ),
              ),
              Divider(),
              TextField(
                autofocus: true,
                controller: emailTextField,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.blue, fontSize: 20),
                decoration: InputDecoration(
                  labelText:"Email",
                  labelStyle: TextStyle(color: Colors.black),
                )
           ),
              Divider(),
              TextField(
                autofocus: true,
                controller: passwordTextField,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.blue, fontSize: 20),
                decoration: InputDecoration(
                  labelText:"Password",
                  labelStyle: TextStyle(color: Colors.black),
                )
              ),
              Divider(),
              Container(
                margin: new EdgeInsets.only(top: 25),
                child: ButtonTheme(
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: onButtonPress,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                    child: Text(
                      "Enviar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color:Colors.blue,
                  ),
                ),
              ),
            ],
         ),
        ),
      )
      
    );
  }

  void onButtonPress() async {
    var api = new API();

    api.signIn(emailTextField.text, passwordTextField.text).then((response) {
      var common = new Common();

      var token = response["token"];
      common.setPreferences("token", token);
      common.setPreferences("token_expiration", response["expiration"]);

      var clientService = new ClientService();

      clientService.get(token).then((responseClient){
        print(responseClient);
        common.setPreferences("idUser", responseClient.user.id);
        common.setPreferences("nameUser", responseClient.user.name);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      });
    });
  }
}