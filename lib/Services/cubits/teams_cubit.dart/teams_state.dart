part of 'teams_cubit.dart';

@immutable
sealed class TeamsState {}

final class TeamsInitial extends TeamsState {}

final class TeamsLoading extends TeamsState {}

final class TeamsSuccess extends TeamsState {
  final TeamsResponse? teamsResponse;
  TeamsSuccess(this.teamsResponse);
}

final class TeamsError extends TeamsState {
  final String? error;
  TeamsError(this.error);
}
