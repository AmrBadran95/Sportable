import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:sportable/data/models/teams_model.dart';

part 'search_teams_state.dart';

class SearchTeamsCubit extends Cubit<SearchTeamsState> {
  final List<Team?> allTeams = [];

  SearchTeamsCubit() : super(SearchTeamsInitial());

  void setAllTeams(List<Team?> teams) {
    allTeams.clear();
    allTeams.addAll(teams);
    emit(SearchTeamsInitial());
  }

  Future<void> search(String query) async {
    try {
      emit(SearchTeamsLoading());

      if (query.trim().isEmpty) {
        emit(SearchTeamsInitial());
        return;
      }

      final result =
          allTeams.where((team) {
            final name = team?.teamName?.toLowerCase() ?? '';
            return name.contains(query.toLowerCase());
          }).toList();

      if (result.isEmpty) {
        emit(SearchTeamsNotfound("Team is not found!"));
      } else {
        emit(SearchTeamsFound(result));
      }
    } catch (e) {
      emit(SearchTeamsNotfound(e.toString()));
    }
  }
}
