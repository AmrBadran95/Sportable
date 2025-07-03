part of 'topscorers_cubit.dart';

@immutable
sealed class TopscorersState {}

final class TopscorersInitial extends TopscorersState {}

final class TopscorersLoading extends TopscorersState {}

final class TopscorersSuccess extends TopscorersState {
  final TopscorersResponse topscorersResponse;
  TopscorersSuccess(this.topscorersResponse);
}

final class TopscorersError extends TopscorersState {
  final String? error;
  TopscorersError(this.error);
}
