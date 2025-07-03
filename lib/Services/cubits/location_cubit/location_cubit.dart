import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> getUserLocation() async {
    try {
      emit(LocationLoading());

      final bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        emit(LocationError('Location service is disabled.'));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        permission = await Geolocator.checkPermission();
      }

      if (permission == LocationPermission.denied) {
        emit(LocationError('Location permission denied.'));
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationError('Location permission permanently denied.'));
        return;
      }

      Position position = await Geolocator.getCurrentPosition();

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String country = placemarks.first.country ?? "";

      emit(LocationSuccess(country));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}
