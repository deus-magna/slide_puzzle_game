import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:slide_puzzle_game/data/models/puzzle.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit()
      : super(
          GameState(
            size: 3,
            puzzle: Puzzle.create(3),
            moves: 0,
            status: GameStatus.initial,
          ),
        );
  Puzzle get puzzle => state.puzzle;

  void onTileTapped(Tile tile) {
    if (puzzle.canMove(tile.currentPosition)) {
      final newPuzzle = puzzle.move(tile);
      final isSolved = newPuzzle.isSolved();

      emit(
        GameState(
          size: state.size,
          puzzle: newPuzzle,
          moves: state.moves + 1,
          status: isSolved ? GameStatus.solved : state.status,
        ),
      );
    }
  }

  void shuffle() {
    emit(
      state.copyWith(
        puzzle: puzzle.shuffle(),
        status: GameStatus.playing,
        moves: 0,
      ),
    );
  }
}
