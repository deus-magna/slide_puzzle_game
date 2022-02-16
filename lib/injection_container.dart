import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_puzzle_game/data/datasources/game_local_datasource.dart';
import 'package:slide_puzzle_game/data/repositories/game_repository_impl.dart';
import 'package:slide_puzzle_game/domain/repositories/game_repository.dart';
import 'package:slide_puzzle_game/domain/use_cases/is_alien_solved.dart';
import 'package:slide_puzzle_game/domain/use_cases/set_alien_solved.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerLazySingleton(() => SetAlienSolved(sl()))
    ..registerLazySingleton(() => IsAlienSolved(sl()))
    ..registerLazySingleton<GameRepository>(() => GameRepositoryImpl(sl()))
    ..registerLazySingleton<GameLocalDatasource>(
        () => GameLocalDatasourceImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
