import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge.dart';

class BadgeWidget extends StatelessWidget {
  final Badge badge;
  final int index;
  final Function() onTap;

  const BadgeWidget({Key? key, required this.badge, required this.index, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: Image.network(badge.levels[index].imageUrl).image)),
              ),
              Flexible(
                child: Text(
                  badge.levels[index].rank,
                  textAlign: TextAlign.center,
                  style: theme.primaryTextTheme.headline3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
