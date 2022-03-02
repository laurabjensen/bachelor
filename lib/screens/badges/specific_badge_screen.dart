import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/screens/app_routes.dart';
import 'package:spejder_app/screens/badges/components/badge_row.dart';

class SpecificBadgeScreen extends StatefulWidget {
  final Badge badge;

  const SpecificBadgeScreen({Key? key, required this.badge}) : super(key: key);
  @override
  _SpecificBadgeScreenState createState() => _SpecificBadgeScreenState();
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class _SpecificBadgeScreenState extends State<SpecificBadgeScreen> {
  final List<Item> _data = generateItems(8);

  Widget _buildPanel() {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: ExpansionPanelList(
        dividerColor: Color(0xff377E62),
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _data[index].isExpanded = !isExpanded;
          });
        },
        children: _data.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      item.headerValue,
                      style: theme.primaryTextTheme.headline3!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
/*                 Container(
                  color: Color(0xff377E62),
                  height: 20,
                ), */
                ],
              );
            },
            body: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ListTile(
                    title: Text(item.expandedValue),
                    subtitle: const Text('To delete this panel, tap the trash can icon'),
                    trailing: const Icon(Icons.delete),
                    onTap: () {
                      setState(() {
                        _data.removeWhere((Item currentItem) => item == currentItem);
                      });
                    })),
            isExpanded: item.isExpanded,
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color(0xff63A288),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 60, 0, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 170,
              width: 200,
              decoration:
                  BoxDecoration(image: /*Image.network('').image*/ null, color: Colors.grey),
            ),
            Text(widget.badge.name,
                style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 25)),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text('Rang', style: theme.primaryTextTheme.headline1),
            ),
            BadgeRow(badge: widget.badge),
            Container(
              child: _buildPanel(),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: SizedBox(
                width: 170,
                height: 51,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.registerBadgeScreen),
                  style: ElevatedButton.styleFrom(primary: Color(0xff377E62)),
                  child: Text(
                    'Registrer mærke',
                    style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 18),
                  ),
                ),
              ),
            ),

            // Læs mere button med icon
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Center(
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.link,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  label: Text(
                    'Læs mere',
                    style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 18),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffACC6B1),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
