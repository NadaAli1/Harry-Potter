import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter/data/api/characters_api.dart';
import 'package:harry_potter/data/repository/character_repository.dart';
import 'app_router.dart';
import 'bussiness_logic/characters_cubit.dart';

main() => runApp(
      HarryPotter(
        appRouter: AppRouter(),
      ),
    );

class HarryPotter extends StatelessWidget {
  const HarryPotter({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharactersCubit>(
          create: (context) => CharactersCubit(
            charactersRepository: CharactersRepository(
              CharacterApi(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
