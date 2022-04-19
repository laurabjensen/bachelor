import 'package:flutter/material.dart';
import 'package:spejder_app/model/user_profile.dart';

class FriendButton extends StatelessWidget {
  final UserProfile userProfile;
  final UserProfile currentUser;
  final Function() onSendFriendRequest;
  final Function() onCancelFriendRequest;
  final Function() onAcceptsFriendRequest;
  final Function() onRejectFriendRequest;
  final Function() onDeleteFriend;

  const FriendButton(
      {Key? key,
      required this.userProfile,
      required this.currentUser,
      required this.onSendFriendRequest,
      required this.onCancelFriendRequest,
      required this.onAcceptsFriendRequest,
      required this.onRejectFriendRequest,
      required this.onDeleteFriend})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget notFriends() {
      return ElevatedButton(
        onPressed: onSendFriendRequest,
        style: ElevatedButton.styleFrom(primary: Color(0xffc7101f)),
        child: Align(
          alignment: Alignment.center,
          child: Text('Bliv veninder',
              style: theme.primaryTextTheme.headline1!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center),
        ),
      );
    }

//ad5452
    Widget friendRequestSend() {
      return ElevatedButton(
        onPressed: onCancelFriendRequest,
        style: ElevatedButton.styleFrom(primary: Color(0xffaf5057)),
        child: Align(
          alignment: Alignment.center,
          child: Text('Annuller anmodning',
              style: theme.primaryTextTheme.headline1!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center),
        ),
      );
    }

    Widget friendRequestReceived() {
      return Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text('${userProfile.name} har sendt en venindeanmodning',
                style: theme.primaryTextTheme.headline1!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: onAcceptsFriendRequest,
                style: ElevatedButton.styleFrom(primary: Color(0xffaf5057)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Godkend',
                      style: theme.primaryTextTheme.headline1!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: onRejectFriendRequest,
                style: ElevatedButton.styleFrom(primary: Color(0xffaf5057)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Afvis',
                      style: theme.primaryTextTheme.headline1!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget isFriends() {
      return Row(
        children: [
          ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(primary: Color(0xffc7101f)),
            child: Align(
              alignment: Alignment.center,
              child: Text('Veninder',
                  style: theme.primaryTextTheme.headline1!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: onDeleteFriend,
            style: ElevatedButton.styleFrom(primary: Color(0xffc7101f)),
            child: Align(
              alignment: Alignment.center,
              child: Text('Fjern',
                  style: theme.primaryTextTheme.headline1!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center),
            ),
          ),
        ],
      );
    }

    //TODO! Hvordan skal det se ud hvis de har sendt en anmodning til dig?
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Builder(builder: (context) {
            if (userProfile.friendRequestsReceived.contains(currentUser.id)) {
              return friendRequestSend();
            }
            if (userProfile.friendRequestsSend.contains(currentUser.id)) {
              return friendRequestReceived();
            }
            if (userProfile.friends.contains(currentUser.id)) {
              return isFriends();
            }
            return notFriends();
          }),
        ),
      ],
    );
  }
}
