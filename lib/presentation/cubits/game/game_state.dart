part of 'game_cubit.dart';

enum GameStatus {
  initial,
  playing,
  solved,
}

class GameState extends Equatable {
  const GameState({
    required this.size,
    required this.puzzle,
    required this.moves,
    required this.status,
  });

  final int size;
  final Puzzle puzzle;

  final int moves;
  final GameStatus status;

  GameState copyWith(
      {int? size,
      Puzzle? puzzle,
      bool? isSolved,
      int? moves,
      GameStatus? status}) {
    return GameState(
      size: size ?? this.size,
      puzzle: puzzle ?? this.puzzle,
      moves: moves ?? this.moves,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [size, puzzle, moves, status];
}
