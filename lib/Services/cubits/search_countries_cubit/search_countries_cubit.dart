import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:sportable/data/models/countries_model.dart';

part 'search_countries_state.dart';

class SearchCountriesCubit extends Cubit<SearchCountriesState> {
  final List<Country?> allCountries = [];

  SearchCountriesCubit() : super(SearchCountriesInitial());

  void setAllCountries(List<Country?> countries) {
    allCountries.clear();
    allCountries.addAll(countries);
    emit(SearchCountriesInitial());
  }

  Future<void> search(String query) async {
    try {
      emit(SearchCountriesLoading());

      if (query.trim().isEmpty) {
        emit(SearchCountriesInitial());
        return;
      }

      final result =
          allCountries.where((country) {
            final name = country?.countryname?.toLowerCase() ?? '';
            return name.contains(query.toLowerCase());
          }).toList();

      if (result.isEmpty) {
        emit(SearchCountriesNotfound("Country not found!"));
      } else {
        emit(SearchCountriesFound(result));
      }
    } catch (e) {
      emit(SearchCountriesNotfound(e.toString()));
    }
  }
}
