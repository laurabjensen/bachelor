import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spejder_app/custom_scaffold.dart';
import 'package:spejder_app/screens/components/custom_app_bar.dart';
import 'package:spejder_app/screens/components/custom_tab_card.dart';
import 'package:spejder_app/screens/group/bloc/group_bloc.dart';
import 'package:spejder_app/screens/patrol/components/patrol_panel_widget.dart';
import 'package:spejder_app/screens/patrol/create_patrol_screen.dart';

class AllPatrolsScreen extends StatefulWidget {
  final GroupBloc groupBloc;
  const AllPatrolsScreen({Key? key, required this.groupBloc}) : super(key: key);

  @override
  State<AllPatrolsScreen> createState() => _AllPatrolsScreenState();
}

class _AllPatrolsScreenState extends State<AllPatrolsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar.basicAppBarWithBackButton(
          onBack: () => Navigator.pop(context), title: 'Patruljer'),
      body: BlocBuilder(
          bloc: widget.groupBloc,
          builder: (context, GroupState state) {
            return ListView(
                padding: EdgeInsets.fromLTRB(18, 24, 18, 16),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(state.patrols.length, (index) {
                  return PatrolPanelWidget(
                    title: state.patrols[index].name,
                    members: state.patrols[index].members,
                    onEditPressed: () => pushNewScreen(context,
                        screen: CreatePatrolScreen(
                          userProfile: state.userProfile,
                          patrol: state.patrols[index],
                        )),
                    isLeader: state.userProfile.rank.title == 'Leder',
                  );
                }));
          }),
    );
  }
}
