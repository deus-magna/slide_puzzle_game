import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle_game/core/framework/animations.dart';
import 'package:slide_puzzle_game/presentation/cubits/game/game_cubit.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_button.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key, required this.state}) : super(key: key);

  final GameState state;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TranslateAnimation(
            duration: const Duration(milliseconds: 2500),
            offset: MediaQuery.of(context).size.height * 0.5,
            child: SpaceButton(
              title: state.status == GameStatus.initial ? 'START' : 'RESET',
              onPressed: () => context.read<GameCubit>().shuffle(),
            ),
          ),
        ),
      ],
    );
  }
}
