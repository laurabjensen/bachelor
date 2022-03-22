import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/repositories/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository = GetIt.instance.get<LoginRepository>();

  LoginBloc() : super(LoginState()) {
    on<EmailChanged>((event, emit) => _nameChanged(event.email, emit));
    on<PasswordChanged>((event, emit) => _passwordChanged(event.password, emit));
    on<LoginPressed>((event, emit) => _loginPressed(emit));
    on<LoginFailure>((event, emit) => _loginFailure(event.failureMessage, emit));
  }

  _nameChanged(String email, Emitter<LoginState> emit) async {
    emit(state.copyWith(email: email));
  }

  _passwordChanged(String password, Emitter<LoginState> emit) async {
    emit(state.copyWith(password: password));
  }

  _loginPressed(Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStateStatus: LoginStateStatus.loading));
    await loginRepository.signinUser(state.email, state.password);
    emit(state.copyWith(loginStateStatus: LoginStateStatus.success));
  }

  _loginFailure(String failureMessage, Emitter<LoginState> emit) async {
    emit(
        state.copyWith(loginStateStatus: LoginStateStatus.failure, failureMessage: failureMessage));
    emit(state.copyWith(loginStateStatus: LoginStateStatus.initial, failureMessage: ''));
  }
}
