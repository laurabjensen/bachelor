import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class BadgePanelWidget extends StatelessWidget {
  final String title;
  final String? text;
  final List<String>? list;
  final bool showList;
  const BadgePanelWidget(
      {required this.title, required this.text, this.list, this.showList = false});
  const BadgePanelWidget.showList(
      {required this.title, required this.list, this.text, this.showList = true});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget expanded() {
      return showList
          ? Column(children: [
              ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    return Text('${index + 1}. ${list![index]}',
                        style: theme.primaryTextTheme.headline2!
                            .copyWith(fontSize: 17, color: Colors.black));
                  })
            ])
          : Text(text!,
              style: theme.primaryTextTheme.headline2!.copyWith(fontSize: 17, color: Colors.black));
    }

    return Padding(
        padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
        child: Card(
          color: Colors.white,
          child: ExpandablePanel(
            theme: const ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              tapBodyToCollapse: true,
            ),
            header: Padding(
                padding: EdgeInsets.all(10),
                child: Text(title,
                    style: theme.primaryTextTheme.headline1!
                        .copyWith(color: Colors.black, fontWeight: FontWeight.bold))),
            collapsed: Container(),
            expanded: expanded(),
            builder: (_, collapsed, expanded) {
              return Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Expandable(
                  collapsed: collapsed,
                  expanded: expanded,
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                ),
              );
            },
          ),
        ));
  }
}
