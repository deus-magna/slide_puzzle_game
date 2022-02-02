import 'package:equatable/equatable.dart';
import 'package:slide_puzzle_game/data/models/position.dart';

class Tile extends Equatable {
  Tile({
    required this.source,
    required this.value,
    required this.validPosition,
    required this.currentPosition,
  });

  final String source;
  final int value;
  final Position validPosition;
  final Position currentPosition;

  Tile move(Position newPosition) {
    return Tile(
      source: source,
      value: value,
      validPosition: validPosition,
      currentPosition: newPosition,
    );
  }

  @override
  List<Object?> get props => [source, value, validPosition, currentPosition];
}
