part of 'countries_cubit.dart';

@immutable
sealed class CountriesState {}

final class CountriesInitial extends CountriesState {}

final class CountriesLoading extends CountriesState {}

final class CountriesSuccess extends CountriesState {
  final CountriesResponse countriesResponse;
  CountriesSuccess(this.countriesResponse);
}

final class CountriesError extends CountriesState {
  final String? error;
  CountriesError(this.error);
}
