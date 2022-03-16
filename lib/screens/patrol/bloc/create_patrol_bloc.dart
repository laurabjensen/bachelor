import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/rank_repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

part 'create_patrol_event.dart';
part 'create_patrol_state.dart';

class CreatePatrolBloc extends Bloc<CreatePatrolEvent, CreatePatrolState> {
  final RankRepository rankRepository = GetIt.instance.get<RankRepository>();
  final UserProfileRepository userProfileRepository = GetIt.instance.get<UserProfileRepository>();

  CreatePatrolBloc() : super(CreatePatrolState()) {
    //on<CreatePatrolEvent>((event, emit));
    on<RankChanged>((event, emit) => _rankChanged(event.rank, emit));
    on<LoadFromFirebase>((event, emit) => _loadFromFirebase(emit));
    add(LoadFromFirebase());
  }

  //Henter userprofile for brugeren der er logget ind
  Future<void> _loadFromFirebase(Emitter<CreatePatrolState> emit) async {
    final ranks = GetIt.instance.get<List<Rank>>();
    emit(state.copyWith(ranks: ranks));
  }

  Future<void> _rankChanged(Rank? rank, Emitter<CreatePatrolState> emit) async {
    if (rank == null) {
      emit(state.copyWith(rank: Rank.empty));
    } else {
      emit(state.copyWith(rank: rank));
    }
  }
}
