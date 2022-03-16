import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/rank_repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

part 'create_patrulje_event.dart';
part 'create_patrulje_state.dart';

class CreatePatruljeBloc
    extends Bloc<CreatePatruljeEvent, CreatePatruljeState> {
  final RankRepository rankRepository = GetIt.instance.get<RankRepository>();
  final UserProfileRepository userProfileRepository =
      GetIt.instance.get<UserProfileRepository>();

  CreatePatruljeBloc(UserProfile userProfile)
      : super(CreatePatruljeState(userprofile: userProfile)) {
    //on<CreatePatruljeEvent>((event, emit));
    on<RankChanged>((event, emit) => _rankChanged(event.rank, emit));

    add(LoadFromFirebase());
  }

  //Henter userprofile for brugeren der er logget ind
  Future<void> _loadFromFirebase(Emitter<CreatePatruljeState> emit) async {
    final ranks = GetIt.instance.get<List<Rank>>();
    emit(state.copyWith(ranks: ranks));
  }

  Future<void> _rankChanged(
      Rank? rank, Emitter<CreatePatruljeState> emit) async {
    if (rank == null) {
      emit(state.copyWith(rank: Rank.empty));
    } else {
      emit(state.copyWith(rank: rank));
    }
  }
}
