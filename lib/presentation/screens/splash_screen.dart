import 'package:sportable/Services/cubits/onboarding_cubit/onboarding_cubit.dart';
import 'package:sportable/Services/cubits/splash_cubit/splash_cubit.dart';
import 'package:sportable/Services/utils/globals.dart';
import 'package:sportable/presentation/screens/home_screen.dart';
import 'package:sportable/presentation/screens/login_screen.dart';
import 'package:sportable/presentation/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashCubit>().initializeApp();
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashFirstLaunch) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (BuildContext context) => BlocProvider(
                    create: (context) => OnboardingCubit(),
                    child: OnboardingScreen(),
                  ),
            ),
          );
        } else if (state is SplashRegister) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
          );
        } else if (state is SplashLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          );
        }
      },
      child: Scaffold(
        body: Container(
          width: Globals.fullSize(context).width,
          height: Globals.fullSize(context).height,

          decoration: BoxDecoration(
            color: Globals.primaryBackground,
            gradient: LinearGradient(
              colors: [Globals.primaryLinear, Globals.secondaryLinear],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  "assets/images/background.svg",
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/box.svg"),
                      SizedBox(width: 16),
                      Text(
                        "sportable",
                        style: TextStyle(
                          fontSize: Globals.header,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 199, 0, 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Text(
                    "Connect with your favorite sport.",
                    style: TextStyle(
                      fontSize: Globals.title,
                      fontWeight: FontWeight.bold,
                      color: Globals.lightFont,
                    ),
                  ),
                  SizedBox(height: 32),
                  CircularProgressIndicator(
                    backgroundColor: Globals.secondaryColor,
                    strokeWidth: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
