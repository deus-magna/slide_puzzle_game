class Tile {
  Tile({
    required this.value,
    required this.source,
    required this.validPosition,
    required this.currentPosition,
  });

  final int value;
  final String source;
  final Position validPosition;
  final Position currentPosition;
}

class Position implements Comparable<Position> {
  /// {@macro position}
  const Position({required this.x, required this.y});

  /// The x position.
  final int x;

  /// The y position.
  final int y;

  @override
  int compareTo(Position other) {
    if (y < other.y) {
      return -1;
    } else if (y > other.y) {
      return 1;
    } else {
      if (x < other.x) {
        return -1;
      } else if (x > other.x) {
        return 1;
      } else {
        return 0;
      }
    }
  }
}
