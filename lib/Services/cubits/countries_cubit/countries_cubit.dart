import 'package:sportable/data/models/countries_model.dart';
import 'package:sportable/data/repos/countries_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final CountriesRepo countriesRepo;
  CountriesCubit(this.countriesRepo) : super(CountriesInitial());

  Future fetchCountries() async {
    try {
      emit(CountriesLoading());
      final response = await countriesRepo.getCountries();

      if (response != null) {
        emit(CountriesSuccess(response));
      } else {
        emit(CountriesError("Failed to get countries data."));
      }
    } catch (e) {
      emit(CountriesError(e.toString()));
    }
  }
}
