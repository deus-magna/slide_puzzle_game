import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:slide_puzzle_game/core/framework/animations.dart';
import 'package:slide_puzzle_game/core/managers/audio/audio_extension.dart';
import 'package:slide_puzzle_game/data/models/game_params.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:slide_puzzle_game/presentation/cubits/game/game_cubit.dart';
import 'package:slide_puzzle_game/presentation/views/game/game_view.dart';
import 'package:slide_puzzle_game/presentation/widgets/difficult_view_background.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_bar.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_button.dart';

class DifficultyView extends StatefulWidget {
  const DifficultyView({Key? key}) : super(key: key);

  @override
  State<DifficultyView> createState() => _DifficultyViewState();
}

class _DifficultyViewState extends State<DifficultyView> {
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer()..setAsset('assets/audio/space_coin.mp3');
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const DifficultViewBackground(),
          _buildBody(size, context),
        ],
      ),
    );
  }

  Widget _buildBody(Size size, BuildContext context) {
    const duration = 800;
    final size = MediaQuery.of(context).size;
    final constraints = BoxConstraints(
        maxWidth: (size.width / 2).clamp(200, 300), minHeight: 60);
    return SafeArea(
      child: Column(
        children: [
          const SpaceBar(color: Colors.black),
          Expanded(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      SpaceButton(
                        onPressed: () =>
                            pushGameView(context, GameDifficult.easy),
                        title: AppLocalizations.of(context).difficultEasy,
                        constraints: constraints,
                      ),
                      const SizedBox(height: 25),
                      SpaceButton(
                        onPressed: () =>
                            pushGameView(context, GameDifficult.medimum),
                        title: AppLocalizations.of(context).difficultMedium,
                        duration: const Duration(milliseconds: duration * 2),
                        constraints: constraints,
                      ),
                      const SizedBox(height: 25),
                      SpaceButton(
                        onPressed: () =>
                            pushGameView(context, GameDifficult.hard),
                        title: AppLocalizations.of(context).difficultHard,
                        duration: const Duration(milliseconds: duration * 3),
                        constraints: constraints,
                      ),
                      const SizedBox(height: 25),
                      SpaceButton(
                        onPressed: () =>
                            pushGameView(context, GameDifficult.godLevel),
                        title: AppLocalizations.of(context).difficultGooLevel,
                        duration: const Duration(milliseconds: duration * 4),
                        constraints: constraints,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> pushGameView(
    BuildContext context,
    GameDifficult gameDifficult,
  ) async {
    unawaited(player.replay(context));
    final assetData = await getAssetData(gameDifficult);
    final arguments =
        GameParams(assetData: assetData, gameDifficult: gameDifficult);

    await Navigator.of(context).push<void>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: GameView(
              gameParams: arguments,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
    // Navigator.of(context).pushNamed('/game', arguments: arguments);
  }

  Future<Uint8List> getAssetData(GameDifficult difficult) async {
    final bytes = await bytesFromAsset(difficult);
    final mibiByte = bytes.buffer.asUint8List();
    return mibiByte;
  }

  Future<ByteData> bytesFromAsset(GameDifficult difficult) async {
    switch (difficult) {
      case GameDifficult.easy:
        return rootBundle.load('assets/img/tiles/uan/uan.png');
      case GameDifficult.medimum:
        return rootBundle.load('assets/img/tiles/inky/inky.png');
      case GameDifficult.hard:
        return rootBundle.load('assets/img/tiles/ubbi/ubbi.png');
      case GameDifficult.godLevel:
        return rootBundle.load('assets/img/tiles/flamfy/flamfy.png');
    }
  }
}
