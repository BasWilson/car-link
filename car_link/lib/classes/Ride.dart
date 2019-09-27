import 'package:car_link/classes/Sprint.dart';

class Ride {
  final String rideId;
  final double maxSpeed, averageSpeed, fuelUsed, kmStart, kmEnd;
  final Sprint sprint;
  final DateTime timestamp;

  Ride({
    this.rideId,
    this.timestamp,
    this.maxSpeed,
    this.averageSpeed,
    this.fuelUsed,
    this.kmEnd,
    this.kmStart,
    this.sprint
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      rideId: json['rideId'],
      timestamp: json['timestamp'],
      maxSpeed: json['maxSpeed'],
      averageSpeed: json['averageSpeed'],
      fuelUsed: json['fuelUsed'],
      kmEnd: json['kmEnd'],
      kmStart: json['kmStart'],
      sprint: json['sprint'],
    );
  }

}