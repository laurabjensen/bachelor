import 'package:flutter/material.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';

class AllPatrolsScreen extends StatefulWidget {
  const AllPatrolsScreen({Key? key}) : super(key: key);

  @override
  State<AllPatrolsScreen> createState() => _AllPatrolsScreenState();
}

class _AllPatrolsScreenState extends State<AllPatrolsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar.basicAppBarWithBackButton(
          onBack: () => Navigator.pop(context), title: 'Patruljer'),
      body: Container(),
    );
  }
}
