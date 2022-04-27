import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/authentication_repository.dart';
import 'package:spejder_app/repositories/repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  final UserProfileRepository userProfileRepository;

  AuthenticationBloc(this.authenticationRepository, this.userProfileRepository)
      : super(AuthenticationState()) {
    on<StreamStarted>((event, emit) async {
      await emit
          .onEach<UserProfile>(GetIt.instance.get<UserProfileRepository>().getUser(state.user?.uid),
              onData: (updatedUser) {
        add(UserUpdatedAuthentication(updatedUser));
      });
    }, transformer: restartable());
    on<AppStarted>((event, emit) => _appStarted(emit));
    on<LoggedIn>((event, emit) => _loggedIn(emit));
    on<LoggedOut>((event, emit) => _loggedOut(emit));
    on<UpdateState>((event, emit) => _appStarted(emit));
    on<UserUpdatedAuthentication>(((event, emit) => _userUpdated(event.userProfile, emit)));

    add(AppStarted());
  }

  Future<void> _appStarted(Emitter<AuthenticationState> emit) async {
    await Repository().loadConstants();
    try {
      final signedIn = await authenticationRepository.isSignedIn();
      if (signedIn) {
        final user = authenticationRepository.getUser();
        final userProfile = await userProfileRepository.getUserprofileFromId(user!.uid);
        emit(state.copyWith(
            status: AuthenticationStateStatus.authenticated, user: user, userProfile: userProfile));
        add(StreamStarted());
      } else {
        emit(AuthenticationState());
      }
    } catch (_) {
      emit(AuthenticationState());
    }
  }

  Future<void> _loggedIn(Emitter<AuthenticationState> emit) async {
    final user = authenticationRepository.getUser();
    final userProfile = await userProfileRepository.getUserprofileFromId(user!.uid);
    emit(state.copyWith(
        status: AuthenticationStateStatus.authenticated, user: user, userProfile: userProfile));
  }

  Future<void> _loggedOut(Emitter<AuthenticationState> emit) async {
    emit(AuthenticationState());
    authenticationRepository.signOut();
  }

  Future<void> _userUpdated(UserProfile userProfile, Emitter<AuthenticationState> emit) async {
    userProfile = await userProfileRepository.getUserprofileFromId(userProfile.id);
    emit(state.copyWith(userProfile: userProfile));
  }
}
