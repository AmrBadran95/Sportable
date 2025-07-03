part of 'leagues_cubit.dart';

@immutable
sealed class LeaguesState {}

final class LeaguesInitial extends LeaguesState {}

final class LeaguesLoading extends LeaguesState {}

final class LeaguesSuccess extends LeaguesState {
  final LeaguesResponse leaguesResponse;
  LeaguesSuccess(this.leaguesResponse);
}

final class LeaguesError extends LeaguesState {
  final String? error;
  LeaguesError(this.error);
}
