import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/screens/components/navbar.dart';
import 'package:spejder_app/screens/leader/components/approve_badge_widget.dart';

class ApproveBadgesScreen extends StatefulWidget {
  @override
  _ApproveBadgesScreenState createState() => _ApproveBadgesScreenState();
}

class _ApproveBadgesScreenState extends State<ApproveBadgesScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final list = GetIt.instance.get<List<Badge>>();

    return CustomScaffold(
      body: CustomNavBar(
        padding: EdgeInsets.only(top: 40, left: 10),
        widget: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Godkend mærker',
                    style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 30),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return ApproveBadgeWidget(
                            badgeSpecific: list[index].levels[3],
                          );
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
