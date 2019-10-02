import 'dart:convert';

import 'package:car_link/views/Drives.dart';

class Ride {
  final String id, linkedCar;
  final int driveEnd, driveStart;
  final String sprints;
  bool isExpanded;

  Ride({
    this.id,
    this.linkedCar,
    this.driveEnd,
    this.driveStart,
    this.sprints,
    this.isExpanded
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'],
      linkedCar: json['linkedCar'],
      driveEnd: json['driveEnd'],
      driveStart: json['driveStart'],
      sprints: json['sprints'].toString(),
      isExpanded: false
    );
  }

    static Resource<List<Ride>> get all {
    return Resource(
        url: "http://uber2.nl/api/getDrives",
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((model) => Ride.fromJson(model)).toList();
        });
  }

}