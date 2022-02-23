import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:slide_puzzle_game/data/models/puzzle.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';
import 'package:slide_puzzle_game/domain/use_cases/get_best_results_for_alien.dart';
import 'package:slide_puzzle_game/domain/use_cases/set_alien_solved.dart';
import 'package:slide_puzzle_game/domain/use_cases/set_best_results_for_alien.dart';
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
  final GetBestResultsForAlien getBestResultsForAlien =
      sl<GetBestResultsForAlien>();
  final SetBestResultsForAlien setBestResultsForAlien =
      sl<SetBestResultsForAlien>();

  Puzzle get puzzle => state.puzzle;

  void onKeyboardKeyTaped(PhysicalKeyboardKey key) {
    final index = _handleKeyboard(key, state);

    if (index != -1) {
      onTileTapped(
        puzzle.tiles[index],
      );
    }
  }

  int _handleKeyboard(PhysicalKeyboardKey key, GameState state) {
    final crossAxisCount = state.size;
    final emptyPosition = puzzle.whiteSpace;
    final tiles = puzzle.tiles;

    if (state.status != GameStatus.playing) {
      return -1;
    }
    var index = -1;

    if (key == PhysicalKeyboardKey.arrowUp) {
      if (emptyPosition.y + 1 <= crossAxisCount - 1) {
        index = tiles.indexWhere(
          (tile) {
            return tile.currentPosition.x == emptyPosition.x &&
                tile.currentPosition.y == emptyPosition.y + 1;
          },
        );
      }
    } else if (key == PhysicalKeyboardKey.arrowDown) {
      if (emptyPosition.y > 0) {
        index = tiles.indexWhere(
          (tile) {
            return tile.currentPosition.x == emptyPosition.x &&
                tile.currentPosition.y == emptyPosition.y - 1;
          },
        );
      }
    } else if (key == PhysicalKeyboardKey.arrowRight) {
      if (emptyPosition.x <= crossAxisCount) {
        index = tiles.indexWhere(
          (tile) {
            return tile.currentPosition.x + 1 == emptyPosition.x &&
                tile.currentPosition.y == emptyPosition.y;
          },
        );
      }
    } else if (key == PhysicalKeyboardKey.arrowLeft) {
      if (emptyPosition.x >= 0) {
        index = tiles.indexWhere(
          (tile) {
            return tile.currentPosition.x - 1 == emptyPosition.x &&
                tile.currentPosition.y == emptyPosition.y;
          },
        );
      }
    }

    return index;
  }

  Future<void> onTileTapped(Tile tile) async {
    if (puzzle.canMove(tile.currentPosition)) {
      final newPuzzle = puzzle.move(tile);
      final isSolved = newPuzzle.isSolved();

      emit(
        state.copyWith(
          puzzle: newPuzzle,
          moves: state.moves + 1,
          status: isSolved ? GameStatus.solved : state.status,
        ),
      );
    }
  }

  Future<void> addAlienToAlbum(int time) async {
    await setAlienSolved(alienName: state.alienName);
    final bestMoves =
        getBestResultsForAlien(alienName: '${state.alienName}_results').first;
    if (bestMoves == 0) {
      await setBestResultsForAlien(
          alienName: '${state.alienName}_results', values: [state.moves, time]);
    } else if (bestMoves > state.moves) {
      await setBestResultsForAlien(
          alienName: '${state.alienName}_results', values: [state.moves, time]);
    }
  }

  void pause() => emit(state.copyWith(
      status: state.status == GameStatus.paused
          ? GameStatus.playing
          : GameStatus.paused));

  void shuffle() => emit(
        state.copyWith(
          puzzle: puzzle.shuffle(),
          status: GameStatus.playing,
          moves: 0,
        ),
      );
}
