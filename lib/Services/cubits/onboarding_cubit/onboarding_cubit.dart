import 'package:sportable/Services/shared/app_cache.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  Future completeOnboarding() async {
    await AppCache.setFirstInstalled(false);
    emit(OnboardingSkipped());
  }
}
