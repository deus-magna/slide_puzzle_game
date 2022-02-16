import 'package:slide_puzzle_game/domain/repositories/game_repository.dart';

class SetAlienSolved {
  SetAlienSolved(this.gameRepository);

  final GameRepository gameRepository;

  Future<void> call({required String alienName}) async {
    await gameRepository.setSolved(alienName);
  }
}
