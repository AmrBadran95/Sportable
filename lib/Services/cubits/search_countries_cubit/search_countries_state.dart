part of 'search_countries_cubit.dart';

@immutable
sealed class SearchCountriesState {}

final class SearchCountriesInitial extends SearchCountriesState {}

final class SearchCountriesLoading extends SearchCountriesState {}

final class SearchCountriesFound extends SearchCountriesState {
  final List<Country?> country;
  SearchCountriesFound(this.country);
}

final class SearchCountriesNotfound extends SearchCountriesState {
  final String error;
  SearchCountriesNotfound(this.error);
}
