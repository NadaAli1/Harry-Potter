import 'package:flutter/material.dart';
import 'package:harry_potter/constant/fonts.dart';
import 'package:harry_potter/peresentation/screens/characters_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenView(
        navigateRoute: const CharactersScreen(),
        duration: 5000,
        imageSize: 400,
        imageSrc: "assets/images/splash.png",
        text: 'Harry Potter',
        textStyle: TextStyle(
          fontFamily: MyFonts.myCrow,
          fontSize: 60,
          //fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}
