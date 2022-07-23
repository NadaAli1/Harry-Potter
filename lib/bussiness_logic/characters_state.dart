part of 'characters_cubit.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<AllCharacters> characters;

  CharactersLoaded(this.characters);
}
