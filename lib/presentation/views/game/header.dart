import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/core/framework/animations.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.moves,
    required this.width,
  }) : super(key: key);

  final int moves;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SpaceContainer(
            label: 'TIMER',
            value: '02:30',
            animationOffset: -400,
            duration: Duration(milliseconds: 1000),
            direction: Axis.horizontal,
          ),
          const SizedBox(width: 20),
          SpaceContainer(
            label: 'MOVES',
            value: '$moves',
            animationOffset: 400,
            duration: const Duration(milliseconds: 1000),
            direction: Axis.horizontal,
          ),
        ],
      ),
    );
  }
}

class SpaceContainer extends StatelessWidget {
  const SpaceContainer({
    Key? key,
    required this.label,
    required this.value,
    required this.animationOffset,
    required this.duration,
    required this.direction,
  }) : super(key: key);

  final String label;
  final String value;
  final double animationOffset;
  final Duration duration;
  final Axis direction;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TranslateAnimation(
        duration: duration,
        offset: animationOffset,
        offsetDirection: direction,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: spaceContainerDecoration,
          child: Column(
            children: [
              Text(label, style: Theme.of(context).textTheme.caption),
              Text(
                value,
                style: Theme.of(context).textTheme.button,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
