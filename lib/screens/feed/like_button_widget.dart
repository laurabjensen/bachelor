import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonWidget extends StatefulWidget {
  const LikeButtonWidget({Key? key}) : super(key: key);

  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  bool isLiked = false;
  int likeCount = 17;

  @override
  Widget build(BuildContext context) {
    const double sizeOfHeart = 20;

    return LikeButton(
      size: sizeOfHeart,
      isLiked: isLiked,
      likeCount: likeCount,
      // Få farve på hjerte til at ændre sig
      likeBuilder: (isLiked) {
        final color = isLiked ? Colors.green : Colors.grey;
        final icon = isLiked ? Icons.favorite : Icons.add_reaction_outlined;
        return Icon(icon, color: color, size: sizeOfHeart);
      },
      //Circle og bubbles color er på animationen ved like
      circleColor: CircleColor(start: Colors.black, end: Colors.green),
      bubblesColor:
          BubblesColor(dotPrimaryColor: Colors.black, dotSecondaryColor: Colors.greenAccent),

      //Afstand mellem hjerte og likes
      likeCountPadding: EdgeInsets.only(left: 2),
      // Antal likes og styling af dette
      countBuilder: (count, isLiked, text) {
        final color = isLiked ? Colors.green : Colors.grey;
        return Text(text,
            style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.bold));
      },
      onTap: (isLiked) async {
        //Keep state of likes
        this.isLiked = !isLiked;
        likeCount += this.isLiked ? 1 : -1;

        //server request

        return !isLiked;
      },
    );
  }
}
