part of 'search_teams_cubit.dart';

@immutable
sealed class SearchTeamsState {}

final class SearchTeamsInitial extends SearchTeamsState {}

final class SearchTeamsLoading extends SearchTeamsState {}

final class SearchTeamsFound extends SearchTeamsState {
  final List<Team?> teams;
  SearchTeamsFound(this.teams);
}

final class SearchTeamsNotfound extends SearchTeamsState {
  final String error;
  SearchTeamsNotfound(this.error);
}
