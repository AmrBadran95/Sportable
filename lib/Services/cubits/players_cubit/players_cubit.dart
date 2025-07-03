import 'package:sportable/data/models/player_model.dart';
import 'package:sportable/data/repos/players_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'players_state.dart';

class PlayersCubit extends Cubit<PlayersState> {
  final PlayersRepo playersRepo;
  PlayersCubit(this.playersRepo) : super(PlayersInitial());

  Future fetchPlayers(int playerId) async {
    try {
      emit(PlayersLoading());
      final response = await playersRepo.getPlayers(playerId);
      if (response != null) {
        emit(PlayersSuccess(response));
      } else {
        emit(PlayersError("Failed to get Players data"));
      }
    } catch (e) {
      emit(PlayersError(e.toString()));
    }
  }
}
