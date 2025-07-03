part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashFirstLaunch extends SplashState {}

final class SplashRegister extends SplashState {}

final class SplashLoggedIn extends SplashState {}
