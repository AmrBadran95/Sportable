import 'package:sportable/Services/Auth/google_auth.dart';
import 'package:sportable/Services/shared/app_cache.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'google_auth_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  GoogleAuthCubit() : super(GoogleAuthInitial());

  Future<void> signIn() async {
    emit(GoogleAuthLoading());
    try {
      final userCredential = await GoogleAuth.SigninWithGoogle();
      if (userCredential != null) {
        emit(GoogleAuthSignedIn(userCredential.user!));
        AppCache.setLoggedIn(true);
      } else {
        emit(GoogleAuthFailure("User cancelled login"));
      }
    } catch (e) {
      emit(GoogleAuthFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await GoogleAuth.signoutWithGoogle();
      emit(GoogleAuthSignedOut());
      AppCache.setLoggedIn(false);
    } catch (e) {
      emit(GoogleAuthFailure(e.toString()));
    }
  }

  Future<void> getUserData() async {
    try {
      emit(GoogleAuthLoading());
      final user = await GoogleAuth.getDataWithGoogle();
      if (user != null) {
        emit(GoogleAuthSignedIn(user));
      } else {
        emit(GoogleAuthFailure("No user found"));
      }
    } catch (e) {
      emit(GoogleAuthFailure(e.toString()));
    }
  }
}
