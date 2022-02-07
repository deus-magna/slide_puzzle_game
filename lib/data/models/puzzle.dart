import 'dart:math' as math;
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image/image.dart' as imglib;

import 'package:slide_puzzle_game/data/models/position.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';

class Puzzle extends Equatable {
  const Puzzle._({required this.tiles, required this.whiteSpace});

  factory Puzzle.create(int size, Uint8List data) {
    var value = 1;
    final whiteSpace = Position(x: size - 1, y: size - 1);

    final list = List<int>.from(data);
    final datas = splitImage(list, size);

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
            source: datas[value - 1],
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

  static List<Uint8List> splitImage(List<int> input, int size) {
    // convert image to image from image package
    final image = imglib.decodeImage(input);

    var x = 0, y = 0;
    final width = (image!.width / size).round();
    final height = (image.height / size).round();

    // split image to parts
    final parts = <imglib.Image>[];
    for (var i = 0; i < size; i++) {
      for (var j = 0; j < size; j++) {
        parts.add(imglib.copyCrop(image, x, y, width, height));
        x += width;
      }
      x = 0;
      y += height;
    }

    // convert image from image package to Image Widget to display
    final output = <Uint8List>[];
    for (final img in parts) {
      final image8List = Uint8List.fromList(imglib.encodeJpg(img));
      output.add(image8List);
    }

    return output;
  }

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

  /// shuffle the puzzle tiles
  Puzzle shuffle() {
    final values = List.generate(
      tiles.length,
      (index) => index + 1,
    )
      ..add(0)
      ..shuffle();

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

  bool _isSolvable(List<int> values) {
    final n = math.sqrt(values.length);

    /// inversions
    var inversions = 0;
    var y = 1;
    var emptyPositionY = 1;

    for (var i = 0; i < values.length; i++) {
      if (i > 0 && i % n == 0) {
        y++;
      }

      final current = values[i];
      if (current == 1 || current == 0) {
        if (current == 0) {
          emptyPositionY = y;
        }
        continue;
      }
      for (var j = i + 1; j < values.length; j++) {
        final next = values[j];

        if (current > next && next != 0) {
          inversions++;
        }
      }
    }

    // is odd
    if (n % 2 != 0) {
      return inversions.isOdd;
    } else {
      // is even

      final yFromBottom = n - emptyPositionY + 1;

      if (yFromBottom % 2 == 0) {
        return inversions % 2 != 0;
      } else {
        return inversions.isOdd;
      }
    }
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
