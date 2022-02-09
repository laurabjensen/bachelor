import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'badges_event.dart';
part 'badges_state.dart';

class BadgesBloc extends Bloc<BadgesEvent, BadgesState> {
  BadgesBloc() : super(BadgesInitial());

  @override
  Stream<BadgesState> mapEventToState(
    BadgesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
