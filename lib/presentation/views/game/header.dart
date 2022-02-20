import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle_game/core/framework/animations.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/core/utils/utils.dart' as utils;
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:slide_puzzle_game/presentation/cubits/timer_bloc/timer_bloc.dart';

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
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);

    return SizedBox(
      width: width,
      height: MediaQuery.of(context).size.height * 0.12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SpaceContainer(
            label: AppLocalizations.of(context).gameTimer,
            value: utils.readableTimer(duration),
            animationOffset: -400,
            duration: const Duration(milliseconds: 2500),
            direction: Axis.horizontal,
          ),
          const SizedBox(width: 20),
          SpaceContainer(
            label: AppLocalizations.of(context).gameMoves,
            value: '$moves',
            animationOffset: 400,
            duration: const Duration(milliseconds: 2500),
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
            mainAxisAlignment: MainAxisAlignment.center,
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
