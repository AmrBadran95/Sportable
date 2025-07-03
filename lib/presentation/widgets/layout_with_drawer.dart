import 'package:sportable/Services/cubits/googleAuth_cubit/google_auth_cubit.dart';
import 'package:sportable/Services/utils/globals.dart';
import 'package:sportable/presentation/screens/home_screen.dart';
import 'package:sportable/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class LayoutWithDrawer extends StatelessWidget {
  final Widget child;
  final bool showBackArrow;
  LayoutWithDrawer({super.key, required this.child, this.showBackArrow = true});

  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.primaryBackground,
      body: SafeArea(
        child: SliderDrawer(
          slideDirection: SlideDirection.rightToLeft,
          key: _sliderDrawerKey,
          appBar: SliderAppBar(
            config: SliderAppBarConfig(
              backgroundColor: Globals.primaryBackground,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (showBackArrow)
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios),
                    ),
                ],
              ),
            ),
          ),
          sliderOpenSize: 180,
          slider: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Globals.secondaryBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: BlocProvider(
              create: (context) => GoogleAuthCubit()..getUserData(),
              child: BlocBuilder<GoogleAuthCubit, GoogleAuthState>(
                builder: (context, state) {
                  if (state is GoogleAuthLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Globals.secondaryColor,
                        strokeWidth: 3,
                      ),
                    );
                  } else if (state is GoogleAuthFailure) {
                    return Center(child: Text(state.error));
                  } else if (state is GoogleAuthSignedIn) {
                    final user = state.user;
                    return Column(
                      children: [
                        SizedBox(height: 24),
                        Center(
                          child: Text(
                            "INFO",
                            style: TextStyle(
                              fontSize: Globals.title,
                              fontWeight: FontWeight.bold,
                              color: Globals.secondaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              user.photoURL ?? "",
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.broken_image, size: 100);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user.displayName ?? "",
                              style: TextStyle(
                                color: Globals.darkFont,
                                fontSize: Globals.title,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Globals.primaryBackground,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (BuildContext context) => HomeScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Home",
                                style: TextStyle(
                                  color: Globals.darkFont,
                                  fontSize: Globals.title,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Globals.secondaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () async {
                                await context.read<GoogleAuthCubit>().signOut();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (BuildContext context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  color: Globals.lightFont,
                                  fontSize: Globals.title,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: Text("Please Sign in!"));
                  }
                },
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
