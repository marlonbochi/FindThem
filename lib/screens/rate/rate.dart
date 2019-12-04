
import 'package:find_them/models/rate.dart' as model;
import 'package:find_them/services/rateService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Rate extends StatefulWidget {
  final int requestID;
  final int clientID;
  final int providerID;
  final String token;
  final String providerName;
  final String serviceName;

  const Rate({Key key, this.token, this.requestID, this.clientID, this.providerID, this.providerName, this.serviceName}): super(key: key);

  @override
  _RateState createState() => _RateState();
}

class _RateState extends State<Rate> {

  double rating = 0;

  void initState() {

  }

  void sendRate() {

    var rateService = new RateService();

    var rate = new model.Rate(0, widget.requestID, widget.clientID, widget.providerID, rating.round(), true);

    rateService.create(widget.token, rate).then((success) {

      if (success) {
        Navigator.of(context).pop(null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Avaliar"),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(null),
              ),
            ],
          ),
          body: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Divider(),Container(
                    child: Text("Avalie o serviço prestado como um todo"),
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  Container(
                    child: Text("Prestador de serviço: " + widget.providerName),
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  Container(
                    child: Text("Serviço: " + widget.serviceName),
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        setState(() {
                          rating = v;
                        });
                        sendRate();
                      },
                      starCount: 5,
                      rating: rating,
                      size: 40.0,
                      color: Colors.green,
                      borderColor: Colors.green,
                      spacing:0.0
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}