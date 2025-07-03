import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportable/Services/cubits/googleAuth_cubit/google_auth_cubit.dart';
import 'package:sportable/Services/shared/app_cache.dart';
import 'package:sportable/Services/utils/globals.dart';
import 'package:sportable/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Globals.fullSize(context).width,
        height: Globals.fullSize(context).height,
        decoration: BoxDecoration(color: Globals.primaryBackground),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Get started with sportable",
                  style: TextStyle(
                    fontSize: Globals.title,
                    color: Globals.darkFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: Icon(Icons.visibility_off),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(width: 12),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Globals.secondaryColor,
                          fontSize: Globals.subtitle,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    await AppCache.setLoggedIn(true);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: Globals.fullSize(context).width,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Globals.secondaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          color: Globals.lightFont,
                          fontSize: Globals.subtitle,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Globals.darkFont,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      'OR',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Globals.darkFont,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Globals.darkFont,
                        indent: 10,
                      ),
                    ),
                  ],
                ),
                BlocListener<GoogleAuthCubit, GoogleAuthState>(
                  listener: (context, state) {
                    if (state is GoogleAuthSignedIn) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen(),
                        ),
                      );
                    } else if (state is GoogleAuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.error,
                            style: TextStyle(fontSize: Globals.subtitle),
                          ),
                          backgroundColor: Globals.secondaryColor,
                        ),
                      );
                    }
                  },
                  child: InkWell(
                    onTap: () async {
                      context.read<GoogleAuthCubit>().signIn();
                    },
                    child: Container(
                      width: Globals.fullSize(context).width,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: BoxBorder.all(
                          width: 2,
                          color: Globals.darkFont,
                        ),
                        color: Globals.primaryBackground,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/google.svg"),
                            SizedBox(width: 18),
                            Text(
                              "Continue With Google",
                              style: TextStyle(
                                color: Globals.darkFont,
                                fontSize: Globals.subtitle,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: Globals.fullSize(context).width,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: BoxBorder.all(width: 2, color: Globals.darkFont),
                    color: Globals.primaryBackground,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/facebook.svg"),
                        SizedBox(width: 18),
                        Text(
                          "Continue With Facebook",
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: Globals.fullSize(context).width,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: BoxBorder.all(width: 2, color: Globals.darkFont),
                    color: Globals.primaryBackground,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/apple.svg"),
                        SizedBox(width: 18),
                        Text(
                          textAlign: TextAlign.end,
                          "Continue With Apple",
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "By continuing, you agree to our Terms and Conditions",
                          style: TextStyle(
                            fontSize: Globals.body,
                            color: Globals.darkFont,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
