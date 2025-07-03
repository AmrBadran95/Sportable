import 'package:sportable/Services/shared/app_cache.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> initializeApp() async {
    await Future.delayed(Duration(seconds: 5));
    await AppCache.reload();
    final bool isFirstInstalled = AppCache.isFirstInstalled;
    final bool isLoggedIn = AppCache.isLoggedIn;

    if (isFirstInstalled) {
      emit(SplashFirstLaunch());
    } else if (isLoggedIn == false) {
      emit(SplashRegister());
    } else {
      emit(SplashLoggedIn());
    }
  }
}
