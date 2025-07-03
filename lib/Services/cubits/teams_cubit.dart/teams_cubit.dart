import 'package:sportable/data/models/teams_model.dart';
import 'package:sportable/data/repos/teams_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  final TeamsRepo teamsRepo;
  TeamsCubit(this.teamsRepo) : super(TeamsInitial());

  Future fetchTeams(int leagueId) async {
    try {
      emit(TeamsLoading());
      final response = await teamsRepo.getTeams(leagueId);

      if (response != null) {
        emit(TeamsSuccess(response));
      } else {
        emit(TeamsError("Failed to get Teams data"));
      }
    } catch (e) {
      emit(TeamsError(e.toString()));
    }
  }
}
