import 'package:flutter/material.dart';
import 'package:spejder_app/model/badge_specific.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadMoreButton extends StatelessWidget {
  final BadgeSpecific badgeSpecific;

  const ReadMoreButton({Key? key, required this.badgeSpecific})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    void openUrl() async {
      final Uri emailLaunchUri = Uri(
        scheme: 'https',
        path: badgeSpecific.link.replaceFirst('https://', ''),
      );
      launchUrl(emailLaunchUri);
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Center(
        child: ElevatedButton.icon(
          icon: Icon(
            Icons.link,
            color: Colors.white,
            size: 24.0,
          ),
          label: Text(
            'Læs mere',
            style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 18),
          ),
          onPressed: () => openUrl(),
          style: ElevatedButton.styleFrom(
            primary: Color(0xffACC6B1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}
