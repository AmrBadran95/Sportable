import 'package:sportable/data/models/leagues_model.dart';
import 'package:sportable/data/repos/leagues_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


part 'leagues_state.dart';

class LeaguesCubit extends Cubit<LeaguesState> {
  final LeaguesRepo leaguesRepo;
  LeaguesCubit(this.leaguesRepo) : super(LeaguesInitial());

  Future fetchLeagues(int countryId) async {
    try {
      emit(LeaguesLoading());
      final response = await leaguesRepo.getLeagues(countryId);

      if (response != null) {
        emit(LeaguesSuccess(response));
      } else {
        emit(LeaguesError("Failed to get Leagues data"));
      }
    } catch (e) {
      emit(LeaguesError(e.toString()));
    }
  }
}
