import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter/data/api/characters_api.dart';
import 'package:harry_potter/data/models/all_characters.dart';
import 'package:harry_potter/data/repository/character_repository.dart';
import 'package:harry_potter/peresentation/screens/characters_details_screen.dart';
import 'package:harry_potter/peresentation/screens/characters_screen.dart';
import 'package:harry_potter/peresentation/screens/splash_screen.dart';
import 'bussiness_logic/characters_cubit.dart';
import 'constant/string.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(
      CharacterApi(),
    );
    charactersCubit =
        CharactersCubit(charactersRepository: charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashscreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final selectedCharacter = settings.arguments as AllCharacters;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CharactersCubit(
              charactersRepository: charactersRepository,
            ),
            child: CharacterDetailsScreen(
              character: selectedCharacter,
            ),
          ),
        );
    }
  }
}
