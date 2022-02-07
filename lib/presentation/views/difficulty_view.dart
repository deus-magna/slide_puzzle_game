import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slide_puzzle_game/data/models/game_params.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:slide_puzzle_game/presentation/cubits/game/game_cubit.dart';
import 'package:slide_puzzle_game/presentation/widgets/difficult_view_background.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_button.dart';

class DifficultyView extends StatelessWidget {
  const DifficultyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const DifficultViewBackground(
            backgroundImage:
                'assets/img/backgrounds/difficult_view_background.png',
          ),
          SizedBox(
            width: size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SpaceButton(
                  onPressed: () => pushGameView(context, GameDifficult.easy),
                  title: AppLocalizations.of(context).difficultEasy,
                ),
                const SizedBox(height: 25),
                SpaceButton(
                  onPressed: () => pushGameView(context, GameDifficult.medimum),
                  title: AppLocalizations.of(context).difficultMedium,
                ),
                const SizedBox(height: 25),
                SpaceButton(
                  onPressed: () => pushGameView(context, GameDifficult.hard),
                  title: AppLocalizations.of(context).difficultHard,
                ),
                const SizedBox(height: 25),
                SpaceButton(
                  onPressed: () =>
                      pushGameView(context, GameDifficult.godLevel),
                  title: AppLocalizations.of(context).difficultGooLevel,
                ),
              ],
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
    final assetData = await getAssetData();
    final arguments =
        GameParams(assetData: assetData, gameDifficult: gameDifficult);
    Navigator.of(context).pushNamed('/game', arguments: arguments);
  }

  Future<Uint8List> getAssetData() async {
    final bytes = await rootBundle.load('assets/img/tiles/uan/uan.png');
    final mibiByte = bytes.buffer.asUint8List();
    return mibiByte;
  }
}
