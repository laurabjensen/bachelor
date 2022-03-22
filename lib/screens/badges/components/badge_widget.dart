import 'package:flutter/material.dart';
import 'package:spejder_app/extensions.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:collection/collection.dart';

class BadgeWidget extends StatelessWidget {
  final Badge badge;
  final int index;
  final Function(BadgeSpecific) onTap;
  final List<BadgeRegistration>? registrationList;
  final BadgeSpecific selectedBadge;

  const BadgeWidget(
      {Key? key,
      required this.badge,
      required this.index,
      required this.onTap,
      required this.registrationList,
      required this.selectedBadge})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Get firebase values for rank an capitalize them
    var rank = (badge.levels[index].rank);
    //Bool used to show if badge is registred or not

    bool isAccepted() {
      var registration =
          registrationList!.firstWhereOrNull((element) => element.badgeSpecific.rank == rank);
      if (registration != null) {
        return registration.getStatus() == BadgeRegistrationStatus.accepted;
      }
      return false;
    }

    return GestureDetector(
        onTap: () => onTap(badge.levels[index]),
        child: Container(
          foregroundDecoration: BoxDecoration(
            border: Border.all(
                color: selectedBadge.rank == rank ? Color(0xff377E62) : Colors.white, width: 3),
            borderRadius: BorderRadius.circular(8),
            color: isAccepted() ? Colors.transparent : Colors.grey,
            backgroundBlendMode: isAccepted() ? null : BlendMode.saturation,
          ),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: Image.network(badge.levels[index].imageUrl)
                          .image, /*colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation)*/
                    )),
                  ),
                  rank.id == 'seniorspejder'
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
                            rank.title.capitalize(),
                            textAlign: TextAlign.center,
                            style: theme.primaryTextTheme.headline3,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ));
  }
}
