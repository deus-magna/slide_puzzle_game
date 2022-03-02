import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle_game/core/framework/animations.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:slide_puzzle_game/presentation/cubits/game_cubit/game_cubit.dart';
import 'package:slide_puzzle_game/presentation/cubits/timer_bloc/timer_bloc.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_button.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key, required this.state, required this.width})
      : super(key: key);

  final GameState state;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TranslateAnimation(
              duration: const Duration(milliseconds: 2500),
              offset: -400,
              offsetDirection: Axis.horizontal,
              child: SpaceButton(
                isShortButton: true,
                title: state.status == GameStatus.initial
                    ? AppLocalizations.of(context).gameStart
                    : AppLocalizations.of(context).gameRestart,
                onPressed: () {
                  context.read<TimerBloc>().add(const TimerStarted());
                  context.read<GameCubit>().shuffle();
                },
              ),
            ),
          ),
          Expanded(
            child: TranslateAnimation(
              duration: const Duration(milliseconds: 2500),
              offset: 400,
              offsetDirection: Axis.horizontal,
              child: SpaceButton(
                isShortButton: true,
                title: state.status == GameStatus.paused
                    ? AppLocalizations.of(context).gameContinue
                    : AppLocalizations.of(context).gamePause,
                onPressed: () {
                  if (state.status == GameStatus.paused ||
                      state.status == GameStatus.playing) {
                    if (state.status == GameStatus.paused) {
                      context.read<TimerBloc>().add(const TimerResumed());
                    } else {
                      context.read<TimerBloc>().add(const TimerPaused());
                    }
                    context.read<GameCubit>().pause();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
