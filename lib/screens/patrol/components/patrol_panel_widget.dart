import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/profile/components/profile_friend_widget.dart';

class PatrolPanelWidget extends StatelessWidget {
  final String title;
  final List<UserProfile> members;
  final Function() onEditPressed;
  final bool isLeader;

  const PatrolPanelWidget(
      {Key? key,
      required this.title,
      required this.members,
      required this.onEditPressed,
      required this.isLeader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
        child: SizedBox(
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ExpandableNotifier(child: Builder(builder: (context) {
              var controller = ExpandableController.of(context, required: true)!;
              return ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Builder(
                  builder: (context) {
                    //var controller = ExpandableController.of(context, required: true)!;
                    return SizedBox(
                      height: 55,
                      width: 336,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Expanded(
                              child: Text(title,
                                  style: theme.primaryTextTheme.headline3!.copyWith(fontSize: 20)),
                            ),
                            controller.expanded && isLeader
                                ? IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: onEditPressed,
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    ))
                                : Container()
                          ])),
                    );
                  },
                ),

                /**/
                collapsed: Container(),
                expanded: ListView(
                  //physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                  shrinkWrap: true,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: GridView.count(
                            physics:
                                NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                            shrinkWrap: true,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            crossAxisCount: 2,
                            children: List.generate(members.length, (index) {
                              return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff377E62)),
                                  child: ProfileFriendWidget(
                                    //badge: friends[index],
                                    userProfile: members[index],
                                  ));
                            }))),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  //var controller = ExpandableController.of(context, required: true)!;
                  return Container(
                    decoration: BoxDecoration(
                        color: controller.expanded ? Color(0xffACC6B1) : Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    ),
                  );
                },
              );
            })),
          ),
        ));
  }
}
