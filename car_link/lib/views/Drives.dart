import 'package:car_link/views/DriveDetail.dart';
import 'package:car_link/views/GasMoneyRoute.dart';
import 'package:flutter/material.dart';

// stores ExpansionPanel state information
class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: '08:2$index - 08:4$index',
      expandedValue: '27/09/2019',
    );
  });
}

class RidesRoute extends StatefulWidget {
  RidesRoute({Key key}) : super(key: key);

  @override
  RidesRouteState createState() => RidesRouteState();
}

class RidesRouteState extends State<RidesRoute> {
  List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: Icon(Icons.directions_car),
              title: Text(item.headerValue),
              subtitle: Text(item.expandedValue),
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
                              ActionChip(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GasMoneyRoute()),
                                  );
                                },
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
