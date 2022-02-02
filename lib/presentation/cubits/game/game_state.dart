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
    required this.isSolved,
    required this.moves,
    required this.status,
  });

  final int size;
  final Puzzle puzzle;
  final bool isSolved;
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
      isSolved: isSolved ?? this.isSolved,
      moves: moves ?? this.moves,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [size, puzzle, isSolved, moves, status];
}
