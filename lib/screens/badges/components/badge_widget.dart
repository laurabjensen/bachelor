import 'package:flutter/material.dart';
import 'package:spejder_app/extensions.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_specific.dart';

class BadgeWidget extends StatelessWidget {
  final Badge badge;
  final int index;
  final Function(BadgeSpecific) onTap;

  const BadgeWidget({Key? key, required this.badge, required this.index, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var rank = (badge.levels[index].rank).capitalize();

    return GestureDetector(
      onTap: () => onTap(badge.levels[index]),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: Image.network(badge.levels[index].imageUrl).image)),
              ),
              rank == 'Seniorspejder'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          'Senior',
                          style: TextStyle(height: 0.9),
                        ),
                        Text('spejder', style: TextStyle(height: 0.9))
                      ],
                    )
                  : Flexible(
                      child: Text(
                        rank,
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
