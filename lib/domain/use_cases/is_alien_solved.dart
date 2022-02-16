import 'package:slide_puzzle_game/domain/repositories/game_repository.dart';

class IsAlienSolved {
  IsAlienSolved(this.gameRepository);

  final GameRepository gameRepository;

  bool call({required String alienName}) => gameRepository.isSolved(alienName);
}
