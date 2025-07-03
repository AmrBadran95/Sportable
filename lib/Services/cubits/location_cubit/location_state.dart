part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationSuccess extends LocationState {
  final String country;
  LocationSuccess(this.country);
}

final class LocationError extends LocationState {
  final String error;
  LocationError(this.error);
}
