import 'package:equatable/equatable.dart';
import 'package:slide_puzzle_game/data/models/position.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';

class Puzzle extends Equatable {
  const Puzzle._({required this.tiles, required this.whiteSpace});

  factory Puzzle.create(int size) {
    var value = 1;
    final whiteSpace = Position(x: size - 1, y: size - 1);
    final sources = getSources(size);
    final tiles = <Tile>[];
    for (var y = 0; y < size; y++) {
      for (var x = 0; x < size; x++) {
        final isWhiteSpace = y == size - 1 && x == size - 1;
        if (!isWhiteSpace) {
          final position = Position(x: x, y: y);
          final tile = Tile(
            source: sources[value - 1],
            validPosition: position,
            currentPosition: position,
            value: value,
          );
          value++;
          tiles.add(tile);
        }
      }
    }
    return Puzzle._(
      tiles: tiles,
      whiteSpace: whiteSpace,
    );
  }

  final List<Tile> tiles;

  final Position whiteSpace;

  bool canMove(Position currentPosition) =>
      currentPosition.x == whiteSpace.x || currentPosition.y == whiteSpace.y;

  Puzzle move(Tile tile) {
    final copy = [...tiles];
    // left or right
    if (tile.currentPosition.y == whiteSpace.y) {
      final row = tiles
          .where((element) => element.currentPosition.y == whiteSpace.y)
          .toList();

      // right
      if (tile.currentPosition.x < whiteSpace.x) {
        for (final selectedTile in row) {
          if (selectedTile.currentPosition.x < tile.currentPosition.x ||
              selectedTile.currentPosition.x > whiteSpace.x) {
            continue;
          }
          copy[selectedTile.value - 1] = selectedTile.move(
            Position(
              x: selectedTile.currentPosition.x + 1,
              y: selectedTile.currentPosition.y,
            ),
          );
        }
      } else {
        // left
        for (final selectedTile in row) {
          if (selectedTile.currentPosition.x > tile.currentPosition.x ||
              selectedTile.currentPosition.x < whiteSpace.x) {
            continue;
          }
          copy[selectedTile.value - 1] = selectedTile.move(
            Position(
              x: selectedTile.currentPosition.x - 1,
              y: selectedTile.currentPosition.y,
            ),
          );
        }
      }
    } else {
      // top or bottom
      final column = tiles
          .where((element) => element.currentPosition.x == whiteSpace.x)
          .toList();
      // down
      if (tile.currentPosition.y < whiteSpace.y) {
        for (final selectedTile in column) {
          if (selectedTile.currentPosition.y < tile.currentPosition.y ||
              selectedTile.currentPosition.y > whiteSpace.y) {
            continue;
          }
          copy[selectedTile.value - 1] = selectedTile.move(
            Position(
              x: selectedTile.currentPosition.x,
              y: selectedTile.currentPosition.y + 1,
            ),
          );
        }
      } else {
        // up
        for (final selectedTile in column) {
          if (selectedTile.currentPosition.y > tile.currentPosition.y ||
              selectedTile.currentPosition.y < whiteSpace.y) {
            continue;
          }
          copy[selectedTile.value - 1] = selectedTile.move(
            Position(
              x: selectedTile.currentPosition.x,
              y: selectedTile.currentPosition.y - 1,
            ),
          );
        }
      }
    }
    return Puzzle._(tiles: copy, whiteSpace: tile.currentPosition);
  }

  static List<String> getSources(int size) {
    switch (size) {
      case 3:
        return [
          'assets/img/tiles/uan/uan_1.png',
          'assets/img/tiles/uan/uan_1.png',
          'assets/img/tiles/uan/uan_2.png',
          'assets/img/tiles/uan/uan_3.png',
          'assets/img/tiles/uan/uan_4.png',
          'assets/img/tiles/uan/uan_5.png',
          'assets/img/tiles/uan/uan_6.png',
          'assets/img/tiles/uan/uan_7.png',
          'assets/img/tiles/uan/uan_8.png',
        ];

      default:
        return [
          'assets/img/tiles/uan/uan_1.png',
          'assets/img/tiles/uan/uan_1.png',
          'assets/img/tiles/uan/uan_2.png',
          'assets/img/tiles/uan/uan_3.png',
          'assets/img/tiles/uan/uan_4.png',
          'assets/img/tiles/uan/uan_5.png',
          'assets/img/tiles/uan/uan_6.png',
          'assets/img/tiles/uan/uan_7.png',
          'assets/img/tiles/uan/uan_8.png',
          'assets/img/tiles/uan/uan_1.png',
          'assets/img/tiles/uan/uan_1.png',
          'assets/img/tiles/uan/uan_2.png',
          'assets/img/tiles/uan/uan_3.png',
          'assets/img/tiles/uan/uan_4.png',
          'assets/img/tiles/uan/uan_5.png',
          'assets/img/tiles/uan/uan_6.png',
          'assets/img/tiles/uan/uan_7.png',
          'assets/img/tiles/uan/uan_8.png',
          'assets/img/tiles/uan/uan_1.png',
          'assets/img/tiles/uan/uan_1.png',
          'assets/img/tiles/uan/uan_2.png',
          'assets/img/tiles/uan/uan_3.png',
          'assets/img/tiles/uan/uan_4.png',
          'assets/img/tiles/uan/uan_5.png',
          'assets/img/tiles/uan/uan_6.png',
          'assets/img/tiles/uan/uan_7.png',
          'assets/img/tiles/uan/uan_8.png',
          'assets/img/tiles/uan/uan_1.png',
          'assets/img/tiles/uan/uan_1.png',
          'assets/img/tiles/uan/uan_2.png',
          'assets/img/tiles/uan/uan_3.png',
          'assets/img/tiles/uan/uan_4.png',
          'assets/img/tiles/uan/uan_5.png',
          'assets/img/tiles/uan/uan_6.png',
          'assets/img/tiles/uan/uan_7.png',
          'assets/img/tiles/uan/uan_8.png',
        ];
    }
  }

  @override
  List<Object?> get props => [tiles, whiteSpace];
}
