import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:slide_puzzle_game/data/models/puzzle.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit._(int size)
      : super(
          GameState(
            size: size,
            puzzle: Puzzle.create(size),
            moves: 0,
            status: GameStatus.initial,
          ),
        );

  factory GameCubit.easy() => GameCubit._(3);

  factory GameCubit.medimun() => GameCubit._(4);

  factory GameCubit.hard() => GameCubit._(5);

  factory GameCubit.godLevel() => GameCubit._(6);

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
