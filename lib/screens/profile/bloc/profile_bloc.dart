import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spejder_app/model/user_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
