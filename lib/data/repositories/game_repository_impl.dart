import 'package:slide_puzzle_game/data/datasources/game_local_datasource.dart';
import 'package:slide_puzzle_game/domain/repositories/game_repository.dart';

class GameRepositoryImpl extends GameRepository {
  GameRepositoryImpl(this.gameLocalDatasource);

  final GameLocalDatasource gameLocalDatasource;

  @override
  bool isSolved(String key) => gameLocalDatasource.isSolved(key);

  @override
  Future<void> setSolved(String key) async {
    await gameLocalDatasource.setSolved(key);
  }
}
