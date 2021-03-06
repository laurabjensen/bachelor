import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/screens/badges/bloc/badges_bloc.dart';

class DescriptionBadgePanelWidget extends StatefulWidget {
  final String title;
  final String? text;

  final Function(String text) onDescriptionSaved;

  const DescriptionBadgePanelWidget({
    required this.title,
    required this.text,
    required this.onDescriptionSaved,
  });

  @override
  State<DescriptionBadgePanelWidget> createState() => _DescriptionBadgePanelWidgetState();
}

class _DescriptionBadgePanelWidgetState extends State<DescriptionBadgePanelWidget> {
  late TextEditingController controller = TextEditingController(text: widget.text ?? '');
  late ThemeData theme;
  late BadgesBloc badgesBloc = BlocProvider.of(context);

  Widget textFormField() {
    return Column(children: [
      SizedBox(
        height: 102,
        child: TextFormField(
          style: theme.primaryTextTheme.headline4,
          controller: controller,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              hintText: 'Skriv om nogle af de oplevelser du har haft i forbindelse med mærket',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: theme.primaryTextTheme.headline3!.copyWith(height: 0)),
          keyboardType: TextInputType.multiline,
          //onChanged: onChanged,
          maxLines: 5,
        ),
      ),
      TextButton(
          onPressed: () {
            widget.onDescriptionSaved(controller.text);
          },
          child: Text('Gem beskrivelse'))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
        child: Card(
          color: Colors.white,
          child: ExpandableNotifier(
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToCollapse: true,
              ),
              header: Builder(
                builder: (context) {
                  var controller = ExpandableController.of(context, required: true)!;
                  return Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(widget.title,
                            style: theme.primaryTextTheme.headline1!
                                .copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
                        controller.expanded
                            ? IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => badgesBloc.add(EditingToggled()),
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ))
                            : Container()
                      ]));
                },
              ),

              /**/
              collapsed: Container(),
              expanded: Builder(builder: (context) {
                return badgesBloc.state.isEditing
                    ? textFormField()
                    : Text(widget.text!.isNotEmpty ? widget.text! : 'Ingen beskrivelse givet.',
                        style: theme.primaryTextTheme.headline2!
                            .copyWith(fontSize: 17, color: Colors.black));
              }),
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
          ),
        ));
  }
}
