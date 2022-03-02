import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterBadgeScreen extends StatefulWidget {
  RegisterBadgeScreen({Key? key}) : super(key: key);

  @override
  State<RegisterBadgeScreen> createState() => _RegisterBadgeScreenState();
}

class _RegisterBadgeScreenState extends State<RegisterBadgeScreen> {
  String _selectedDate = 'Tap to select date';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2020),
    );
    if (d != null)
      setState(() {
        _selectedDate = DateFormat.yMMMMd("en_US").format(d);
      });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color(0xff63A288),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Spejder mærke i stort
              Container(
                height: 170,
                width: 200,
                decoration:
                    BoxDecoration(image: /*Image.network('').image*/ null, color: Colors.grey),
              ),
              // Titel på spejdermærke
              Text('Navn', style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 25)),
              // Rang på det viste spejdermærke
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text('Rang', style: theme.primaryTextTheme.headline1),
              ),

              // Dato
              Text('Hvornår har du taget mærket?',
                  style: theme.primaryTextTheme.headline1!.copyWith(fontWeight: FontWeight.bold)),
              // Date picker
              Center(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1.0, color: Colors.black),
                            left: BorderSide(width: 1.0, color: Colors.black),
                            right: BorderSide(width: 1.0, color: Colors.black),
                            bottom: BorderSide(width: 1.0, color: Colors.black),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            InkWell(
                              child: Text(_selectedDate,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Color(0xFF000000))),
                              onTap: () {
                                _selectDate(context);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.calendar_today),
                              tooltip: 'Klik for at åbne dato vælger',
                              onPressed: () {
                                _selectDate(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Din beskrivelse
              Text('Din beskrivelse',
                  style: theme.primaryTextTheme.headline1!.copyWith(fontWeight: FontWeight.bold)),
              // Beskrivelses felt

              // Button leder godkendelse
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: SizedBox(
                  width: 170,
                  height: 51,
                  child: ElevatedButton(
                    onPressed: () => null,
                    style: ElevatedButton.styleFrom(primary: Color(0xff377E62)),
                    child: Text(
                      'Send til leder godkendelse',
                      style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 18),
                    ),
                  ),
                ),
              ),
              // Button læs mere
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
      ),
    );
  }
}
