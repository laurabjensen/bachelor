import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:spejder_app/model/user_profile.dart';

class LikeButtonWidget extends StatefulWidget {
  final UserProfile currentUser;
  final List<String> likeList;
  final Function(bool isLiked) onTap;
  const LikeButtonWidget(
      {Key? key,
      required this.currentUser,
      required this.likeList,
      required this.onTap})
      : super(key: key);

  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double sizeOfHeart = 25;

    return LikeButton(
      size: sizeOfHeart,
      isLiked: widget.likeList.contains(widget.currentUser.id),
      likeCount: widget.likeList.length,
      // Få farve på hjerte til at ændre sig
      likeBuilder: (isLiked) {
        final color = isLiked ? Colors.green : Colors.grey;
        final icon = isLiked ? Icons.favorite : Icons.favorite_outline;
        return Icon(icon, color: color, size: sizeOfHeart);
      },
      //Circle og bubbles color er på animationen ved like
      circleColor: CircleColor(start: Colors.black, end: Colors.green),
      bubblesColor: BubblesColor(
          dotPrimaryColor: Colors.redAccent,
          dotSecondaryColor: Colors.greenAccent,
          dotThirdColor: Colors.orangeAccent,
          dotLastColor: Colors.purpleAccent),

      //Afstand mellem hjerte og likes
      likeCountPadding: EdgeInsets.only(left: 2),
      // Antal likes og styling af dette
      countBuilder: (count, isLiked, text) {
        final color = isLiked ? Colors.green : Colors.grey;
        return Text(text,
            style: TextStyle(
                color: color, fontSize: 15, fontWeight: FontWeight.bold));
      },
      onTap: (isLiked) async {
        widget.onTap(!isLiked);
        //Keep state of likes
        //this.isLiked = !isLiked;
        //likeCount += this.isLiked ? 1 : -1;

        //server request

        return !isLiked;
      },
    );
  }
}
