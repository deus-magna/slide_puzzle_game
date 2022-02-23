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

  @override
  List<int> getBestResults(String key) {
    final results = gameLocalDatasource.getBestResults(key);
    if (results.isEmpty) {
      return [0, 0];
    }
    return results.map(int.parse).toList();
  }

  @override
  Future<void> setBestResults(String key, List<int> values) async {
    final results = values.map((result) => result.toString()).toList();
    await gameLocalDatasource.setBestResults(key, results);
  }
}
