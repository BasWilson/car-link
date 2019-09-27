import 'dart:developer';

import 'package:flutter/material.dart';

class GasMoneyRoute extends StatelessWidget {
  @override
  int people = 1;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gas sharing ⛽"),
      ),
      body: Column(
        children: <Widget>[
          Slider(
            value: people.toDouble(),
            min: 1,
            max: 4,
            divisions: 3,
            label: 'Divide by',
            onChanged: (double newVal) {
              
              people = newVal.toInt();
            },
          )
        ],
      ),
    );
  }
}
