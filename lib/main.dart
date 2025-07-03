import 'package:sportable/Services/cubits/googleAuth_cubit/google_auth_cubit.dart';
import 'package:sportable/Services/cubits/splash_cubit/splash_cubit.dart';
import 'package:sportable/Services/shared/app_cache.dart';
import 'package:sportable/Services/utils/globals.dart';
import 'package:sportable/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppCache.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<GoogleAuthCubit>(create: (_) => GoogleAuthCubit()),
        BlocProvider<SplashCubit>(create: (_) => SplashCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sportable',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: Globals.primaryBackground,
        colorScheme: ColorScheme.fromSeed(seedColor: Globals.primaryColor),
      ),
      home: SplashScreen(),
    );
  }
}
