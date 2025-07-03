part of 'google_auth_cubit.dart';

@immutable
sealed class GoogleAuthState {}

final class GoogleAuthInitial extends GoogleAuthState {}

final class GoogleAuthSignedIn extends GoogleAuthState {
  final User user;

  GoogleAuthSignedIn(this.user);
}

final class GoogleAuthSignedOut extends GoogleAuthState {}

final class GoogleAuthLoading extends GoogleAuthState {}

final class GoogleAuthFailure extends GoogleAuthState {
  final String error;

  GoogleAuthFailure(this.error);
}
