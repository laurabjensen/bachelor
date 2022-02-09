import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'leader_event.dart';
part 'leader_state.dart';

class LeaderBloc extends Bloc<LeaderEvent, LeaderState> {
  LeaderBloc() : super(LeaderInitial());

  @override
  Stream<LeaderState> mapEventToState(
    LeaderEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
