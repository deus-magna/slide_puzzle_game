import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_puzzle_game/data/datasources/game_local_datasource.dart';
import 'package:slide_puzzle_game/data/repositories/game_repository_impl.dart';
import 'package:slide_puzzle_game/data/repositories/image_repository_impl.dart';
import 'package:slide_puzzle_game/domain/repositories/game_repository.dart';
import 'package:slide_puzzle_game/domain/repositories/image_repository.dart';
import 'package:slide_puzzle_game/domain/use_cases/get_best_results_for_alien.dart';
import 'package:slide_puzzle_game/domain/use_cases/is_alien_solved.dart';
import 'package:slide_puzzle_game/domain/use_cases/set_alien_solved.dart';
import 'package:slide_puzzle_game/domain/use_cases/set_best_results_for_alien.dart';
import 'package:slide_puzzle_game/domain/use_cases/split_image.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // Use cases
    ..registerLazySingleton(() => SetAlienSolved(sl()))
    ..registerLazySingleton(() => IsAlienSolved(sl()))
    ..registerLazySingleton(() => SplitImage(sl()))
    ..registerLazySingleton(() => SetBestResultsForAlien(sl()))
    ..registerLazySingleton(() => GetBestResultsForAlien(sl()))
    // Repositories
    ..registerLazySingleton<GameRepository>(() => GameRepositoryImpl(sl()))
    ..registerLazySingleton<ImageRepository>(() => ImageRepositoryImpl())
    // Datasources
    ..registerLazySingleton<GameLocalDatasource>(
        () => GameLocalDatasourceImpl(sl()));

  // Core dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
