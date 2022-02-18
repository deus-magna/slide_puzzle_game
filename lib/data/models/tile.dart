import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:slide_puzzle_game/data/models/position.dart';

class Tile extends Equatable {
  const Tile({
    required this.source,
    required this.value,
    required this.validPosition,
    required this.currentPosition,
  });

  final Uint8List? source;
  final int value;
  final Position validPosition;
  final Position currentPosition;

  Tile move(Position newPosition) {
    return Tile(
      value: value,
      source: source,
      validPosition: validPosition,
      currentPosition: newPosition,
    );
  }

  @override
  List<Object?> get props => [source, value, validPosition, currentPosition];
}
