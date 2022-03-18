import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spejder_app/extensions.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:spejder_app/screens/leader/components/button_row.dart';

class ApproveBadgeWidget extends StatelessWidget {
  final BadgeSpecific badgeSpecific;

  const ApproveBadgeWidget({Key? key, required this.badgeSpecific}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 280,
          width: 336,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Mærke + navn
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Mærke
                    SizedBox(
                      height: 168,
                      width: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: Image.network(badgeSpecific.imageUrl).image,
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          Flexible(
                            child: Text(badgeSpecific.badge.name,
                                textAlign: TextAlign.center,
                                style: theme.primaryTextTheme.headline3!.copyWith(fontSize: 22)),
                          ),
                          Text(badgeSpecific.rank.capitalize(),
                              style: theme.primaryTextTheme.headline1!
                                  .copyWith(color: Colors.black, fontSize: 18)),
                        ],
                      ),
                    ),
                    // Profil
                    SizedBox(
                        height: 168,
                        width: 160,
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                        height: 90,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: Color(0xff037B55),
                                        )),
                                    Positioned(
                                        top: 5,
                                        left: 5,
                                        child: SvgPicture.asset(
                                          'assets/tørklæde_rød.svg',
                                          width: 80,
                                          height: 80,
                                        ))
                                  ],
                                ),
                                Text('Mille',
                                    style:
                                        theme.primaryTextTheme.headline3!.copyWith(fontSize: 22)),
                                Text(badgeSpecific.rank.capitalize(),
                                    style: theme.primaryTextTheme.headline1!
                                        .copyWith(color: Colors.black, fontSize: 18)),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              // Dato
              Text(
                'Har taget mærket: DATO',
                style: theme.primaryTextTheme.headline3!.copyWith(
                  fontSize: 20,
                ),
              ),
              // Godkend / Afvis
              ApproveBadgeButtonRow(
                onAccept: () => null,
                onDeny: () => null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
