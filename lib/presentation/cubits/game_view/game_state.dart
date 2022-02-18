part of 'game_cubit.dart';

enum GameDifficult {
  easy,
  medimum,
  hard,
  godLevel,
}

extension GameDifficultExtension on GameDifficult {
  int get size {
    switch (this) {
      case GameDifficult.easy:
        return 3;
      case GameDifficult.medimum:
        return 4;
      case GameDifficult.hard:
        return 5;
      case GameDifficult.godLevel:
        return 6;
    }
  }
}

enum GameStatus {
  loading,
  initial,
  playing,
  solved,
}

class GameState extends Equatable {
  const GameState(
      {required this.size,
      required this.puzzle,
      required this.moves,
      required this.status,
      required this.imageData,
      required this.alienName});

  final int size;
  final Puzzle puzzle;

  final int moves;
  final GameStatus status;
  final Uint8List imageData;
  final String alienName;

  GameState copyWith({
    int? size,
    Puzzle? puzzle,
    bool? isSolved,
    int? moves,
    GameStatus? status,
    Uint8List? imageData,
    String? alienName,
  }) {
    return GameState(
        size: size ?? this.size,
        puzzle: puzzle ?? this.puzzle,
        moves: moves ?? this.moves,
        status: status ?? this.status,
        imageData: imageData ?? this.imageData,
        alienName: alienName ?? this.alienName);
  }

  @override
  List<Object?> get props => [size, puzzle, moves, status, alienName];
}
