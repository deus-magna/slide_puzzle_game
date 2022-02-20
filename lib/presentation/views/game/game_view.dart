import 'dart:async';
import 'dart:math';

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
import 'package:slide_puzzle_game/presentation/cubits/game_cubit/game_cubit.dart';
import 'package:slide_puzzle_game/presentation/cubits/timer_bloc/timer_bloc.dart';
import 'package:slide_puzzle_game/presentation/views/game/board_tile.dart';
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
            final tiles = widget.state.puzzle.tiles;
            return AbsorbPointer(
              absorbing: widget.state.status != GameStatus.playing,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Stack(children: _buildTiles(tiles, tileSize)),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildTiles(List<Tile> tiles, double tileSize) {
    final baseDuration = 2000 / widget.state.size;
    final length = widget.state.size * widget.state.size;

    final random = Random();
    final animation = TileAnimation.values[random.nextInt(2) + 1];

    return tiles.map((tile) {
      final index = tiles.indexOf(tile);
      var duration = (baseDuration * index).toInt();
      var offset = 0.0;
      switch (animation) {
        case TileAnimation.cascade:
          duration = (baseDuration * index).toInt();
          break;
        case TileAnimation.random:
          duration = (baseDuration * random.nextInt(length)).toInt();
          break;
        case TileAnimation.star:
          offset = (index < length / 2) ? 400 : -800;
          duration = (baseDuration * random.nextInt(length)).toInt();
          break;
      }
      return BoardTile(
        tile: tile,
        size: tileSize,
        offset: offset,
        duration: duration,
        onPressed: () {
          player.replay(context);
          context.read<GameCubit>().onTileTapped(tile);
        },
      );
    }).toList();
  }
}
