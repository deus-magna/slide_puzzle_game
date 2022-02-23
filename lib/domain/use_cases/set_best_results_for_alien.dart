import 'package:slide_puzzle_game/domain/repositories/game_repository.dart';

class SetBestResultsForAlien {
  SetBestResultsForAlien(this.gameRepository);

  final GameRepository gameRepository;

  Future<void> call(
      {required String alienName, required List<int> values}) async {
    await gameRepository.setBestResults(alienName, values);
  }
}
