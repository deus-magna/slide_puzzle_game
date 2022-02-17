part of 'game_cubit.dart';

enum GameDifficult {
  easy,
  medimum,
  hard,
  godLevel,
}

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
    required this.imageData,
  });

  final int size;
  final Puzzle puzzle;

  final int moves;
  final GameStatus status;
  final Uint8List imageData;

  GameState copyWith({
    int? size,
    Puzzle? puzzle,
    bool? isSolved,
    int? moves,
    GameStatus? status,
    Uint8List? imageData,
  }) {
    return GameState(
      size: size ?? this.size,
      puzzle: puzzle ?? this.puzzle,
      moves: moves ?? this.moves,
      status: status ?? this.status,
      imageData: imageData ?? this.imageData,
    );
  }

  @override
  List<Object?> get props => [size, puzzle, moves, status];
}
