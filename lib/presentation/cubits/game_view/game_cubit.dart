import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:slide_puzzle_game/data/models/puzzle.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';
import 'package:slide_puzzle_game/domain/use_cases/set_alien_solved.dart';
import 'package:slide_puzzle_game/injection_container.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit._(int size, Uint8List imageData, List<Uint8List> sources)
      : super(
          GameState(
            size: size,
            puzzle: Puzzle.create(size, sources: sources),
            moves: 0,
            status: GameStatus.initial,
            imageData: imageData,
          ),
        );
  factory GameCubit.init(GameDifficult difficult, Uint8List imageData,
          List<Uint8List> sources) =>
      GameCubit._(difficult.size, imageData, sources);

  // factory GameCubit.easy(Uint8List imageData, List<Uint8List> sources) =>
  //     GameCubit._(3, imageData, sources);

  // factory GameCubit.medimun(Uint8List imageData, List<Uint8List> sources) =>
  //     GameCubit._(4, imageData, sources);

  // factory GameCubit.hard(Uint8List imageData, List<Uint8List> sources) =>
  //     GameCubit._(5, imageData, sources);

  // factory GameCubit.godLevel(Uint8List imageData, List<Uint8List> sources) =>
  //     GameCubit._(6, imageData, sources);

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

  Future<void> _addAlienToAlbum() async {
    var name = '';
    switch (state.size) {
      case 3:
        name = 'Uan';
        break;
      case 4:
        name = 'Inky';
        break;
      case 5:
        name = 'Ubbi';
        break;
      case 6:
        name = 'Flamfly';
        break;
    }
    await setAlienSolved(alienName: name);
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
