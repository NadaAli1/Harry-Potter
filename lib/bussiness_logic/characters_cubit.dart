import 'package:bloc/bloc.dart';
import 'package:harry_potter/data/models/all_characters.dart';
import 'package:harry_potter/data/repository/character_repository.dart';
part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<AllCharacters> characters = [];
  CharactersCubit({required this.charactersRepository})
      : super(
          CharactersInitial(),
        );
  List<AllCharacters> getAllCharacters() {
    charactersRepository.getAllCharacters().then((character) {
      emit(
        CharactersLoaded(character),
      );
      characters = character;
    });
    return characters;
  }
}
