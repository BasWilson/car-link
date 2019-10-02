import 'dart:convert';
import 'dart:io';

import 'package:car_link/classes/Ride.dart';
import 'package:car_link/views/DriveDetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:timeago/timeago.dart' as timeago;

class RidesRoute extends StatefulWidget {
  RidesRoute({Key key}) : super(key: key);

  @override
  RidesRouteState createState() => RidesRouteState();
}

class RidesRouteState extends State<RidesRoute> {
  List<Ride> _data = List<Ride>();

  void _getRides() {
    Webservice().load(Ride.all).then((rides) => {
          setState(() => {_data = rides})
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("🚗🏁"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _getRides();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: _buildPanel(),
          ),
        ));
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Ride item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: Icon(Icons.directions_car),
              title: Text(GetTime(item.driveStart) + " - " + GetTime(item.driveEnd)),
              subtitle: Text(GetDate(item.driveStart)),
            );
          },
          body: Center(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 2.5, 10, 2.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ActionChip(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DriveDetailsRoute()),
                                  );
                                },
                                avatar: CircleAvatar(
                                  child: Icon(Icons.shutter_speed),
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.black26,
                                ),
                                label: Text('7.5 sec'),
                              ),
                              Chip(
                                avatar: CircleAvatar(
                                  child: Icon(Icons.local_gas_station),
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.black26,
                                ),
                                label: Text('10 L'),
                              ),
                              Chip(
                                avatar: CircleAvatar(
                                  child: Icon(Icons.monetization_on),
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.black26,
                                ),
                                label: Text('€16.56'),
                              ),
                              IconButton(
                                icon: Icon(Icons.timeline),
                                color: Colors.black38,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DriveDetailsRoute()),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class Resource<T> {
  final String url;
  T Function(Response response) parse;

  Resource({this.url, this.parse});
}

class Webservice {
  Future<T> load<T>(Resource<T> resource) async {
    var params = {
      "username": "wilson",
      "pinCode": "0000",
      "id": "816a78d0-e54a-11e9-a60c-2be73a5e0663"
    };
    final response = await http.post("http://uber2.nl:3000/api/getDrives",
        body: json.encode(params),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    print(response.statusCode);

    if (response.statusCode == 200) {
      return resource.parse(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

String GetTime(int timestamp) {
  DateTime date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
  return date.hour.toString() + ":" + date.minute.toString();
}


String GetDate(int timestamp) {
  DateTime date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
  return date.day.toString() + "/" + date.month.toString() + "/" + date.year.toString();
}
