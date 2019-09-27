import 'package:car_link/classes/ChartSpeedOverTime.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DriveDetailsRoute extends StatelessWidget {
  @override
  final myFakeDesktopData = [
    new LinearSales(0, 0.0),
    new LinearSales(10, 0.7),
    new LinearSales(20, 1.9),
    new LinearSales(30, 2.3),
    new LinearSales(40, 2.8),
    new LinearSales(50, 3.3),
    new LinearSales(60, 4.1),
    new LinearSales(70, 5.7),
    new LinearSales(80, 6.4),
    new LinearSales(90, 7.0),
    new LinearSales(100, 7.8),
  ];

  /// Create one series with pass in data.
  List<charts.Series<LinearSales, double>> mapChartData(
      List<LinearSales> data) {
    return [
      new charts.Series<LinearSales, double>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeDesktopData,
      )
    ];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accelerations 💨"),
      ),
      body: Column(
        children: <Widget>[
          Container(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.shutter_speed),
                          title: Text("0 - 100 KM/H"),
                          subtitle: Text("7.82 seconds"),
                        ),
                        Container(
                          height: 250,
                          child:
                              SimpleBarChart(mapChartData(myFakeDesktopData)),
                        )
                      ],
                    ))),
          ))
        ],
      ),
    );
  }
}
