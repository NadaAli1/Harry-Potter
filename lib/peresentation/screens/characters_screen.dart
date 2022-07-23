import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:harry_potter/constant/fonts.dart';
import 'package:harry_potter/data/models/all_characters.dart';

import '../../bussiness_logic/characters_cubit.dart';
import '../../constant/colors.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<AllCharacters> allCharacter;
  late List<AllCharacters> searchedForCharacters;
  bool _isSearching = false;
  final _searchEditingController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchEditingController,
      cursorColor: MyColors.myWhite,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myWhite, fontSize: 18),
      ),
      style: const TextStyle(color: MyColors.myWhite, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedCharacter(searchedCharacter);
      },
    );
  }

  void addSearchedCharacter(dynamic searchedCharacter) {
    searchedForCharacters = allCharacter
        .where(
          (character) =>
              character.name.toLowerCase().startsWith(searchedCharacter),
        )
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBar() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myWhite,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearching,
          icon: const Icon(
            Icons.search,
            color: MyColors.myWhite,
          ),
        ),
      ];
    }
  }

  void startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      _searchEditingController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacter = (state).characters;
          return buildLoadedListWidget();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myRed,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myWhite,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchEditingController.text.isEmpty
          ? allCharacter.length
          : searchedForCharacters.length,
      itemBuilder: (_, index) {
        return CharacterItem(
          character: _searchEditingController.text.isEmpty
              ? allCharacter[index]
              : searchedForCharacters[index],
        );
      },
    );
  }

  Widget buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(
        color: MyColors.myWhite,
        fontFamily: MyFonts.myCrow,
        fontSize: 30,
      ),
    );
  }

  Widget buildNoInternet() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/images/no_wifi.png',
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'Can\’t connect,Please Check Your Internet',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myRed,
        title: _isSearching ? _buildSearchField() : buildAppBarTitle(),
        centerTitle: true,
        actions: buildAppBar(),
        leading: _isSearching
            ? const BackButton(
                color: MyColors.myWhite,
              )
            : Container(),
      ),
      // body: buildBlocWidget(),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternet();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
