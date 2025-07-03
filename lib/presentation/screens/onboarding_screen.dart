import 'package:sportable/Services/cubits/onboarding_cubit/onboarding_cubit.dart';
import 'package:sportable/Services/utils/globals.dart';
import 'package:sportable/presentation/screens/login_screen.dart';
import 'package:sportable/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> onboardingScreens = [
      OnboardingPage(
        image: 'assets/images/onboarding1.png',
        title: "All the Sports. None of the Limits.",
        body:
            "Step into the ultimate sports arena—right from your pocket. From kick-off to final whistle, sportable keeps you in the game wherever you go.",
      ),
      OnboardingPage(
        image: 'assets/images/onboarding3.png',
        title: "Live Scores. Instant Thrills.",
        body:
            "Feel the game. Get real-time scores, blazing-fast updates, and highlights that put you front and center, every time.",
      ),
      OnboardingPage(
        image: 'assets/images/onboarding2.png',
        title: "Built for Fans. Powered by Passion.",
        body:
            "Choose your favorite leagues, teams, and players.Every tap brings you closer to what you love.",
      ),
    ];

    return Scaffold(
      body: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingSkipped) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
        },
        child: Stack(
          children: [
            IntroductionScreen(
              rawPages: onboardingScreens,
              infiniteAutoScroll: true,
              autoScrollDuration: 3000,
              dotsDecorator: DotsDecorator(
                color: Globals.primaryColor,
                activeColor: Globals.secondaryColor,
                size: const Size(12, 12),
                activeSize: const Size(16, 16),
                spacing: const EdgeInsets.symmetric(horizontal: 6),
              ),
              controlsMargin: const EdgeInsets.all(28),
              showDoneButton: false,
              showSkipButton: false,
              showNextButton: false,
              showBackButton: false,
            ),
            Positioned(
              bottom: 40,
              right: 40,
              child: GestureDetector(
                onTap: () {
                  context.read<OnboardingCubit>().completeOnboarding();
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: Globals.body,
                    fontWeight: FontWeight.bold,
                    color: Globals.secondaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
