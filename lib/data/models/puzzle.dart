import 'dart:math' as math;
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'package:slide_puzzle_game/data/models/position.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';

class Puzzle extends Equatable {
  const Puzzle._({
    required this.tiles,
    required this.whiteSpace,
  });

  factory Puzzle.create(int size, {required List<Uint8List> sources}) {
    var value = 1;
    final whiteSpace = Position(x: size - 1, y: size - 1);

    final tiles = <Tile>[];
    for (var y = 0; y < size; y++) {
      for (var x = 0; x < size; x++) {
        final isWhiteSpace = y == size - 1 && x == size - 1;
        if (!isWhiteSpace) {
          final position = Position(x: x, y: y);
          final tile = Tile(
            validPosition: position,
            currentPosition: position,
            value: value,
            source: sources[value - 1],
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

  // The tiles and his data
  final List<Tile> tiles;

  // Indicates blank space
  final Position whiteSpace;

  bool canMove(Position currentPosition) =>
      currentPosition.x == whiteSpace.x || currentPosition.y == whiteSpace.y;

  List<Tile> _whiteSpaceRow() =>
      tiles.where((tile) => tile.currentPosition.y == whiteSpace.y).toList();

  Puzzle move(Tile tile) {
    final copy = [...tiles];
    // left or right
    if (tile.currentPosition.y == whiteSpace.y) {
      final row = _whiteSpaceRow();

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

  /// shuffle the puzzle tiles
  Puzzle shuffle() {
    final values = List.generate(tiles.length, (index) => index + 1)
      ..add(0)
      ..shuffle();

    // final values = [0, 8, 2, 1, 4, 3, 7, 6, 5];
    // print('Is Solvable? ${_isSolvable(values)}');
    if (_isSolvable(values)) {
      var x = 0, y = 0;
      late Position emptyPosition;
      final copy = [...tiles];
      final crossAxisCount = math.sqrt(values.length).toInt();

      for (var i = 0; i < values.length; i++) {
        final value = values[i];
        final position = Position(x: x, y: y);
        if (value == 0) {
          emptyPosition = position;
        } else {
          copy[value - 1] = copy[value - 1].move(
            position,
          );
        }

        if ((i + 1) % crossAxisCount == 0) {
          y++;
          x = 0;
        } else {
          x++;
        }
      }

      return Puzzle._(
        tiles: copy,
        whiteSpace: emptyPosition,
      );
    } else {
      return shuffle();
    }
  }

  int _findEmptyPosition(List<int> values) {
    final n = math.sqrt(values.length);
    var row = 0, emptyPositionRow = 0;
    for (var i = 0; i < values.length - 1; i++) {
      final current = values[i];
      if (i % n == 0) {
        row++;
      }
      if (current == 0) {
        emptyPositionRow = row;
      }
    }
    // print('emptyPositionRow: $emptyPositionRow');
    return emptyPositionRow;
  }

  int _getInversionsCount(List<int> values) {
    var inversionsCount = 0;
    for (var i = 0; i < values.length - 1; i++) {
      final current = values[i];
      // Si el valor es 1 no tiene inversiones posibles, pasamos al siguiente
      if (current == 1) {
        continue;
      }
      for (var j = i + 1; j < values.length; j++) {
        final next = values[j];
        // Si el valor a la izquierda es el vacio, esa inversion
        if (current > next && next != 0) {
          // Tenemos una nueva inversion Ej. 5 > 1
          inversionsCount++;
        }
      }
    }
    return inversionsCount;
  }

  bool _isSolvable(List<int> values) {
    final n = math.sqrt(values.length).toInt();
    final inversionsCount = _getInversionsCount(values);

    // Si N es impar y el numero de inversiones es par, es solucionable
    if (n.isOdd && inversionsCount.isEven) {
      return true;
    } else if (n.isEven) {
      // Si N es par, necesitamos la posicion del tile vacio
      final emptyPositionRow = _findEmptyPosition(values);
      final emptyPositionRowFromBottom = n - emptyPositionRow + 1;
      // Si el espacio vacio es par y
      // las inversiones son impar, se puede solucionar
      if (emptyPositionRowFromBottom.isEven && inversionsCount.isOdd) {
        return true;
      } else if (emptyPositionRowFromBottom.isOdd && inversionsCount.isEven) {
        // Si el espacio vacio es impar y el numero de
        // inversiones es par, es solucionable
        return true;
      }
    }
    return false;
  }

  bool isSolved() {
    final crossAxisCount = math.sqrt(tiles.length + 1).toInt();

    if (whiteSpace.x == crossAxisCount - 1 &&
        whiteSpace.y == crossAxisCount - 1) {
      for (final tile in tiles) {
        if (tile.currentPosition != tile.validPosition) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  @override
  List<Object?> get props => [tiles, whiteSpace];
}
