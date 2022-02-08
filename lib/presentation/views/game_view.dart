import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/core/managers/audio/audio_extension.dart';
import 'package:slide_puzzle_game/core/managers/audio/cubit/audio_cubit.dart';
import 'package:slide_puzzle_game/data/models/game_params.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:slide_puzzle_game/presentation/cubits/game/game_cubit.dart';
import 'package:slide_puzzle_game/presentation/widgets/game_view_background.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_bar.dart';
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

class PuzzleBoard extends StatefulWidget {
  const PuzzleBoard({Key? key, required this.state}) : super(key: key);

  final GameState state;

  @override
  State<PuzzleBoard> createState() => _PuzzleBoardState();
}

class _PuzzleBoardState extends State<PuzzleBoard> {
  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer()..setAsset('assets/audio/short_laser_gun.wav');
    context.read<AudioCubit>().setAsset('assets/audio/space_chillout.mp3');
    context.read<AudioCubit>().play();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const padding = 12.0;
    return Container(
      decoration: spaceContainerDecoration,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tileSize = (constraints.maxWidth - padding) / widget.state.size;
          return AbsorbPointer(
            absorbing: widget.state.status != GameStatus.playing,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Stack(
                children: widget.state.puzzle.tiles
                    .map((tile) => BoardTile(
                          tile: tile,
                          size: tileSize,
                          onPressed: () {
                            player.replay();
                            context.read<GameCubit>().onTileTapped(tile);
                          },
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
