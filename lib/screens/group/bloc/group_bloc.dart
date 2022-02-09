import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupInitial());

  @override
  Stream<GroupState> mapEventToState(
    GroupEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
