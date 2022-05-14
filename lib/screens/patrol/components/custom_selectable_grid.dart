import 'package:flutter/material.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/profile/components/profile_friend_widget.dart';

class CustomSelectableGrid extends StatefulWidget {
  final List<UserProfile> userProfiles;
  final List<UserProfile> selectedUserProfiles;
  final Function(UserProfile) onTap;

  const CustomSelectableGrid(
      {Key? key,
      required this.userProfiles,
      required this.selectedUserProfiles,
      required this.onTap})
      : super(key: key);

  @override
  _CustomSelectableGridState createState() => _CustomSelectableGridState();
}

class _CustomSelectableGridState extends State<CustomSelectableGrid> {
  // set an int with value -1 since no card has been selected
  int selectedCard = -1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: GridView.count(
          shrinkWrap: true,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          crossAxisCount: 2,
          children: List.generate(widget.userProfiles.length, (index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.selectedUserProfiles.contains(widget.userProfiles[index])
                    ? Color(0xff377E62)
                    : Colors.transparent,
              ),
              child: ProfileFriendWidget(
                //badge: friends[index],
                userProfile: widget.userProfiles[index],
                secondaryOnTap: () => widget.onTap(widget.userProfiles[index]),
              ),
            );
          })),
    ));
  }
}
