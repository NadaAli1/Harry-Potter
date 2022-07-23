import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:harry_potter/data/models/all_characters.dart';

import '../../constant/colors.dart';
import '../../constant/fonts.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final AllCharacters character;
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildDetails(
    String text,
    String text2,
  ) {
    if (text2.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
            Expanded(
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                repeatForever: true,
                animatedTexts: [
                  ColorizeAnimatedText(
                    text2,
                    speed: const Duration(
                      milliseconds: 400,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                    colors: [
                      MyColors.myBlack,
                      Colors.red,
                      MyColors.myRed,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.myRed,
        title: Text(
          character.name,
          style: TextStyle(
            color: MyColors.myWhite,
            fontFamily: MyFonts.myCrow,
            fontSize: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: character.image.isNotEmpty
                      ? FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading.gif',
                          image: character.image,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/no-image.jpg',
                        ),
                ),
              ),
            ),
            buildDetails(
              'Actor Name : ',
              character.actorName,
            ),
            buildDetails(
              'Species : ',
              character.species,
            ),
            buildDetails(
              'Gender : ',
              character.gender,
            ),
            buildDetails(
              'House : ',
              character.house,
            ),
            buildDetails(
              'Date Of Birth : ',
              character.dateOfBirth,
            ),
            buildDetails(
              'Wizard : ',
              character.wizard.toString(),
            ),
            buildDetails(
              'Ancestry : ',
              character.ancestry,
            ),
            buildDetails(
              'Eye Color : ',
              character.eyeColor,
            ),
            buildDetails(
              'Hair Color : ',
              character.hairColor,
            ),
            buildDetails(
              'Patronus : ',
              character.patronus,
            ),
            buildDetails(
              'Alive : ',
              character.alive.toString(),
            ),
            buildDetails(
              'Hogwarts Student : ',
              character.hogwartsStudent.toString(),
            ),
            buildDetails(
              'Hogwarts Staff : ',
              character.hogwartsStaff.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
