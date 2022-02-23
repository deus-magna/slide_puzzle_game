import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/core/framework/animations.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';

enum TileAnimation {
  cascade,
  random,
  star,
}

class BoardTile extends StatelessWidget {
  const BoardTile({
    Key? key,
    required this.tile,
    this.onPressed,
    required this.size,
    this.duration = 800,
    this.offset = 400,
    this.offsetDirection = Axis.vertical,
  }) : super(key: key);

  final Tile tile;
  final double size;
  final int duration;
  final Axis offsetDirection;
  final double offset;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      left: tile.currentPosition.x * size,
      top: tile.currentPosition.y * size,
      child: TranslateAnimation(
        duration: Duration(milliseconds: duration),
        offset: offset,
        offsetDirection: offsetDirection,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            width: size - 4,
            height: size - 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [BoxShadow(offset: Offset(0, 10))],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  ColorFiltered(
                    colorFilter: tile.currentPosition == tile.validPosition
                        ? const ColorFilter.mode(
                            Colors.transparent,
                            BlendMode.multiply,
                          )
                        : const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                    child: Image(
                      image: MemoryImage(tile.source!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    '  ${tile.value}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
