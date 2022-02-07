import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:slide_puzzle_game/data/models/puzzle.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit._(int size, Uint8List imageData)
      : super(
          GameState(
            size: size,
            puzzle: Puzzle.create(size, imageData),
            moves: 0,
            status: GameStatus.initial,
            imageData: imageData,
          ),
        );

  factory GameCubit.easy(Uint8List imageData) => GameCubit._(3, imageData);

  factory GameCubit.medimun(Uint8List imageData) => GameCubit._(4, imageData);

  factory GameCubit.hard(Uint8List imageData) => GameCubit._(5, imageData);

  factory GameCubit.godLevel(Uint8List imageData) => GameCubit._(6, imageData);

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
          imageData: state.imageData,
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
