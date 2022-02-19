import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle_game/core/framework/animations.dart';
import 'package:slide_puzzle_game/presentation/cubits/game_view/game_cubit.dart';
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
              offset: MediaQuery.of(context).size.height * 0.5,
              child: SpaceButton(
                title: state.status == GameStatus.initial ? 'START' : 'RESET',
                onPressed: () {
                  context.read<TimerBloc>().add(const TimerStarted());
                  context.read<GameCubit>().shuffle();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
