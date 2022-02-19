import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:slide_puzzle_game/core/framework/animations.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/core/managers/audio/audio_extension.dart';
import 'package:slide_puzzle_game/core/managers/audio/cubit/audio_cubit.dart';
import 'package:slide_puzzle_game/core/utils/utils.dart' as utils;
import 'package:slide_puzzle_game/data/models/game_params.dart';
import 'package:slide_puzzle_game/data/models/ticker.dart';
import 'package:slide_puzzle_game/data/models/tile.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:slide_puzzle_game/presentation/cubits/game_view/game_cubit.dart';
import 'package:slide_puzzle_game/presentation/cubits/timer_bloc/timer_bloc.dart';
import 'package:slide_puzzle_game/presentation/views/game/header.dart';
import 'package:slide_puzzle_game/presentation/views/game/menu.dart';
import 'package:slide_puzzle_game/presentation/widgets/game_view_background.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_bar.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key, required this.gameParams}) : super(key: key);

  final GameParams gameParams;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => GameCubit.init(
                    gameParams.gameDifficult,
                    gameParams.assetData,
                    gameParams.assets,
                    gameParams.alienName,
                  )),
          BlocProvider(
            create: (_) => TimerBloc(ticker: Ticker()),
          )
        ],
        child: BlocConsumer<GameCubit, GameState>(
          listener: (context, state) async {
            if (state.status == GameStatus.solved) {
              context.read<TimerBloc>().add(const TimerPaused());
              final duration = context.read<TimerBloc>().state.duration;
              Timer(const Duration(milliseconds: 400), () {
                context.read<AudioCubit>().win();
                utils.showMissionCompleteDialog(
                  context,
                  title: AppLocalizations.of(context).missionComplete,
                  timer: utils.readableTimer(duration),
                  label: AppLocalizations.of(context).totalMoves,
                  moves: '${state.moves}',
                  button: AppLocalizations.of(context).levelsButton,
                  onPressed: () {
                    context.read<AudioCubit>().playMenuMusic();
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  },
                  album: AppLocalizations.of(context).albumButton,
                );
              });
            }
          },
          builder: (_, state) {
            final size = MediaQuery.of(context).size;
            // final gameWidth = size.width.clamp(300, 450).toDouble();
            final gameWidth = getValueForScreenType<double>(
              context: context,
              mobile: size.width.clamp(250, 350).toDouble(),
              tablet: size.width.clamp(300, 450).toDouble(),
              desktop: size.width.clamp(300, 450).toDouble(),
            );
            print('gameWidth $gameWidth');
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                const GameViewBackground(),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SpaceBar(
                          onPressed: () =>
                              context.read<AudioCubit>().playMenuMusic(),
                        ),
                        Header(moves: state.moves, width: gameWidth),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: gameWidth,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: PuzzleBoard(state: state, width: gameWidth),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Menu(state: state, width: gameWidth),
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

class PuzzleBoard extends StatefulWidget {
  const PuzzleBoard({Key? key, required this.state, required this.width})
      : super(key: key);

  final GameState state;
  final double width;

  @override
  State<PuzzleBoard> createState() => _PuzzleBoardState();
}

class _PuzzleBoardState extends State<PuzzleBoard> {
  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer()..setAsset('assets/audio/short_laser_gun.wav');
    context.read<AudioCubit>().playGameMusic();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const padding = 12.0;
    return TranslateAnimation(
      duration: const Duration(milliseconds: 1500),
      offset: MediaQuery.of(context).size.height * 0.5,
      child: Container(
        decoration: spaceContainerDecoration,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final tileSize =
                (constraints.maxWidth - padding) / widget.state.size;
            print(
                'tileSize $tileSize and ${tileSize * 3} ${constraints.maxWidth}');
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
                              player.replay(context);
                              context.read<GameCubit>().onTileTapped(tile);
                            },
                          ))
                      .toList(),
                ),
              ),
            );
          },
        ),
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
            // child: Stack(
            //   children: [
            //    Text('(${tile.currentPosition.x},${tile.currentPosition.y})'),
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
