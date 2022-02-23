import 'package:slide_puzzle_game/domain/repositories/game_repository.dart';

class GetBestResultsForAlien {
  GetBestResultsForAlien(this.gameRepository);

  final GameRepository gameRepository;

  List<int> call({required String alienName}) =>
      gameRepository.getBestResults(alienName);
}
