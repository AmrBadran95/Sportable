import 'package:sportable/data/models/topscorers_model.dart';
import 'package:sportable/data/repos/topscorers_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'topscorers_state.dart';

class TopscorersCubit extends Cubit<TopscorersState> {
  final TopscorersRepo topscorersRepo;
  TopscorersCubit(this.topscorersRepo) : super(TopscorersInitial());

  Future fetchTopscorers(int leagueId) async {
    try {
      emit(TopscorersLoading());
      final response = await topscorersRepo.getTopscorers(leagueId);
      if (response != null) {
        emit(TopscorersSuccess(response));
      } else {
        emit(TopscorersError("Failed to get Topscorers data"));
      }
    } catch (e) {
      emit(TopscorersError(e.toString()));
    }
  }
}
