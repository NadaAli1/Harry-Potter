import 'package:flutter/material.dart';
import 'package:harry_potter/constant/colors.dart';
import 'package:harry_potter/constant/fonts.dart';

import '../../constant/string.dart';
import '../../data/models/all_characters.dart';

class CharacterItem extends StatelessWidget {
  final AllCharacters character;
  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 5,
            color: MyColors.myRed,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: character.image.isNotEmpty
                      ? FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loadig.gif',
                          image: character.image,
                          fit: BoxFit.cover,
                        )
                      : Image.asset('assets/images/no-image.jpg'),
                ),
              ),
            ),
            Center(
              child: Text(
                character.name,
                style: TextStyle(fontSize: 40, fontFamily: MyFonts.myCrow),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: Row(
                children: [
                  const Text(
                    'View Character Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        characterDetailsScreen,
                        arguments: character,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_outlined,
                    ),
                    iconSize: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
