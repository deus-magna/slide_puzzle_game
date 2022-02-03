import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle_game/app/app.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';
import 'package:slide_puzzle_game/presentation/cubits/game/game_cubit.dart';
import 'package:slide_puzzle_game/presentation/widgets/game_view_background.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GameCubit(),
        child: BlocBuilder<GameCubit, GameState>(
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
    return Container(
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
              )),
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
        const SpaceContainer(label: 'TIMER', value: '00:02:30'),
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
            Text(label, style: TextStyle(color: Colors.white)),
            Text(value, style: TextStyle(color: Colors.white, fontSize: 30)),
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
    return Container(
      decoration: spaceContainerDecoration,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tileSize = constraints.maxWidth / state.size;
          return AbsorbPointer(
            absorbing: state.status != GameStatus.playing,
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
          margin: const EdgeInsets.all(5),
          width: size - 5,
          height: size - 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber,
            boxShadow: const [BoxShadow(offset: Offset(0, 10))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Text('(${tile.currentPosition.x},${tile.currentPosition.y})'),
                Center(
                  child: Text('${tile.value}'),
                ),
              ],
            ),
            // child: Image(
            //   image: AssetImage(tile.source),
            //   fit: BoxFit.cover,
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
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
            onPressed: () => context.read<GameCubit>().shuffle(),
            icon: const Icon(Icons.replay),
            label: Text(state.status == GameStatus.initial ? 'START' : 'RESET'))
      ],
    ));
  }
}
