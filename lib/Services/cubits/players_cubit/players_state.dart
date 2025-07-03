part of 'players_cubit.dart';

@immutable
sealed class PlayersState {}

final class PlayersInitial extends PlayersState {}

final class PlayersLoading extends PlayersState {}

final class PlayersSuccess extends PlayersState {
  final PlayersResponse playersResponse;
  PlayersSuccess(this.playersResponse);
}

final class PlayersError extends PlayersState {
  final String? error;
  PlayersError(this.error);
}
