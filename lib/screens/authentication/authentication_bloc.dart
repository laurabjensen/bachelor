import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spejder_app/repositories/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc(this.authenticationRepository) : super(AuthenticationState()) {
    on<AppStarted>((event, emit) => _appStarted(emit));
    on<LoggedIn>((event, emit) => _loggedIn(emit));
    on<LoggedOut>((event, emit) => _loggedOut(emit));
    on<UpdateState>((event, emit) => _appStarted(emit));

    add(AppStarted());
  }

  Future<void> _appStarted(Emitter<AuthenticationState> emit) async {
    try {
      final signedIn = await authenticationRepository.isSignedIn();
      if (signedIn) {
        final user = authenticationRepository.getUser();
        emit(state.copyWith(status: AuthenticationStateStatus.authenticated, user: user));
      } else {
        emit(state.copyWith(status: AuthenticationStateStatus.unauthenticated, user: null));
      }
    } catch (_) {
      emit(state.copyWith(status: AuthenticationStateStatus.unauthenticated, user: null));
    }
  }

  Future<void> _loggedIn(Emitter<AuthenticationState> emit) async {
    final user = authenticationRepository.getUser();
    emit(state.copyWith(status: AuthenticationStateStatus.authenticated, user: user));
  }

  Future<void> _loggedOut(Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: AuthenticationStateStatus.unauthenticated, user: null));
    authenticationRepository.signOut();
  }
}
