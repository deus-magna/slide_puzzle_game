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
            isSolved: false,
            moves: 0,
            status: GameStatus.playing,
          ),
        );
  Puzzle get puzzle => state.puzzle;

  void onTileTapped(Tile tile) {
    if (puzzle.canMove(tile.currentPosition)) {
      emit(
        GameState(
          size: state.size,
          puzzle: puzzle.move(tile),
          isSolved: state.isSolved,
          moves: state.moves,
          status: state.status,
        ),
      );
    }
  }
}
