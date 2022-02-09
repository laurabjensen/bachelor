import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsBloc() : super(FriendsInitial());

  @override
  Stream<FriendsState> mapEventToState(
    FriendsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
