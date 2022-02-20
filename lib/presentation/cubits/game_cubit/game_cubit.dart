import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:slide_puzzle_game/data/models/puzzle.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';
import 'package:slide_puzzle_game/domain/use_cases/set_alien_solved.dart';
import 'package:slide_puzzle_game/injection_container.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit._(
    int size,
    Uint8List imageData,
    List<Uint8List> sources,
    String alienName,
  ) : super(
          GameState(
            size: size,
            puzzle: Puzzle.create(size, sources: sources),
            moves: 0,
            status: GameStatus.initial,
            imageData: imageData,
            alienName: alienName,
          ),
        );

  factory GameCubit.init(
    GameDifficult difficult,
    Uint8List imageData,
    List<Uint8List> sources,
    String alienName,
  ) =>
      GameCubit._(
        difficult.size,
        imageData,
        sources,
        alienName,
      );

  // Use case for set when alien is solved
  final SetAlienSolved setAlienSolved = sl<SetAlienSolved>();

  Puzzle get puzzle => state.puzzle;

  Future<void> onTileTapped(Tile tile) async {
    if (puzzle.canMove(tile.currentPosition)) {
      final newPuzzle = puzzle.move(tile);
      final isSolved = newPuzzle.isSolved();
      if (isSolved) {
        await _addAlienToAlbum();
      }

      emit(
        state.copyWith(
          puzzle: newPuzzle,
          moves: state.moves + 1,
          status: isSolved ? GameStatus.solved : state.status,
        ),
      );
    }
  }

  Future<void> _addAlienToAlbum() async =>
      setAlienSolved(alienName: state.alienName);

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
