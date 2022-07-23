import 'package:harry_potter/data/api/characters_api.dart';
import 'package:harry_potter/data/models/all_characters.dart';

class CharactersRepository {
  final CharacterApi characterApi;
  CharactersRepository(this.characterApi);
  Future<List<AllCharacters>> getAllCharacters() async {
    final characters = await characterApi.getAllCharacters();
    return characters
        .map((character) => AllCharacters.fromJson(character))
        .toList();
  }
}
