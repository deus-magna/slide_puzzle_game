import 'package:equatable/equatable.dart';

class AlienEntry extends Equatable {
  const AlienEntry({
    required this.bestMoves,
    required this.bestTime,
    required this.name,
    required this.wieght,
    required this.height,
    required this.nature,
    required this.description,
    required this.imagePath,
    required this.isSolved,
  });

  final String name;
  final String wieght;
  final String height;
  final String nature;
  final String description;
  final String imagePath;
  final bool isSolved;
  final int bestMoves;
  final int bestTime;

  @override
  List<Object?> get props => [
        name,
        wieght,
        height,
        nature,
        description,
        imagePath,
        bestMoves,
        bestTime,
      ];
}
