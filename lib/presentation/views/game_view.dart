import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/data/models/game_params.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';
import 'package:slide_puzzle_game/presentation/cubits/game/game_cubit.dart';
import 'package:slide_puzzle_game/presentation/widgets/game_view_background.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_button.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  GameCubit getCubit(GameParams params) {
    switch (params.gameDifficult) {
      case GameDifficult.easy:
        return GameCubit.easy(params.assetData);
      case GameDifficult.medimum:
        return GameCubit.medimun(params.assetData);
      case GameDifficult.hard:
        return GameCubit.hard(params.assetData);
      case GameDifficult.godLevel:
        return GameCubit.godLevel(params.assetData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameParams =
        ModalRoute.of(context)!.settings.arguments as GameParams?;
    return Scaffold(
      body: BlocProvider(
        create: (context) => getCubit(gameParams!),
        child: BlocConsumer<GameCubit, GameState>(
          listener: (_, state) {
            if (state.status == GameStatus.solved) {
              showDialog<void>(
                context: context,
                builder: (_) => const AlertDialog(
                  title: Text('Congrats'),
                  content: Text('Has completado el puzzle'),
                ),
              );
            }
          },
          builder: (_, state) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                const GameViewBackground(),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SpaceBar(),
                        Header(moves: state.moves),
                        const SizedBox(height: 10),
                        AspectRatio(
                          aspectRatio: 1,
                          child: PuzzleBoard(state: state),
                        ),
                        const SizedBox(height: 10),
                        Menu(state: state),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SpaceBar extends StatelessWidget {
  const SpaceBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),
          IconButton(
            onPressed: () => print('Pressed'),
            icon: const Icon(
              Icons.volume_off_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key, required this.moves}) : super(key: key);

  final int moves;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SpaceContainer(label: 'TIMER', value: '02:30'),
        const SizedBox(width: 20),
        SpaceContainer(
          label: 'MOVES',
          value: '$moves',
        ),
      ],
    );
  }
}

class SpaceContainer extends StatelessWidget {
  const SpaceContainer({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}

class PuzzleBoard extends StatelessWidget {
  const PuzzleBoard({Key? key, required this.state}) : super(key: key);

  final GameState state;

  @override
  Widget build(BuildContext context) {
    const padding = 12.0;
    return Container(
      decoration: spaceContainerDecoration,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tileSize = (constraints.maxWidth - padding) / state.size;
          return AbsorbPointer(
            absorbing: state.status != GameStatus.playing,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Stack(
                children: state.puzzle.tiles
                    .map((tile) => BoardTile(
                          tile: tile,
                          size: tileSize,
                          onPressed: () =>
                              context.read<GameCubit>().onTileTapped(tile),
                        ))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BoardTile extends StatelessWidget {
  const BoardTile({
    Key? key,
    required this.tile,
    this.onPressed,
    required this.size,
  }) : super(key: key);

  final Tile tile;
  final double size;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      left: tile.currentPosition.x * size,
      top: tile.currentPosition.y * size,
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
                Image(
                  image: MemoryImage(tile.source),
                  fit: BoxFit.cover,
                ),
                Text(
                  '  ${tile.value}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            // child: Stack(
            //   children: [
            //     Text('(${tile.currentPosition.x},${tile.currentPosition.y})'),
            //     Center(
            //       child: Text('${tile.value}'),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key? key, required this.state}) : super(key: key);

  final GameState state;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SpaceButton(
            title: state.status == GameStatus.initial ? 'START' : 'RESET',
            onPressed: () => context.read<GameCubit>().shuffle(),
          ),
        ),
      ],
    );
  }
}
