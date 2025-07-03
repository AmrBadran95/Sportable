import 'package:sportable/Services/utils/globals.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String body;
  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: Globals.fullSize(context).width,
            height: Globals.fullSize(context).height,
            color: Globals.primaryBackground,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: Globals.title,
                  fontWeight: FontWeight.bold,
                  color: Globals.darkFont,
                ),
              ),
              SizedBox(height: 10),
              Text(
                body,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Globals.subtitle,
                  color: Globals.darkFont,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
