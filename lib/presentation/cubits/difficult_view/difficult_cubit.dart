import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:slide_puzzle_game/data/models/alien_asset.dart';
import 'package:slide_puzzle_game/data/models/game_params.dart';
import 'package:slide_puzzle_game/domain/use_cases/split_image.dart';
import 'package:slide_puzzle_game/injection_container.dart';
import 'package:slide_puzzle_game/presentation/cubits/game_view/game_cubit.dart';

part 'difficult_state.dart';

class DifficultCubit extends Cubit<DifficultState> {
  DifficultCubit() : super(DifficultInitial());

  // Use case for split image
  final SplitImage _splitImage = sl<SplitImage>();

  Future<void> loadAssets(GameDifficult gameDifficult) async {
    emit(DifficultLoading());
    final assetData = await _bytesFromAsset(gameDifficult);
    final mibiByte = assetData.image.buffer.asUint8List();

    final input = List<int>.from(mibiByte);
    final sources = await _splitImage(input, gameDifficult.size);

    emit(DifficultLoaded(
      GameParams(
        assetData: mibiByte,
        gameDifficult: gameDifficult,
        assets: sources,
        alienName: assetData.name,
      ),
    ));
  }

  Future<AssetData> _bytesFromAsset(GameDifficult difficult) async {
    var maxValue = 3;
    switch (difficult) {
      case GameDifficult.easy:
        maxValue = 3;
        break;
      case GameDifficult.medimum:
        maxValue = 5;
        break;
      case GameDifficult.hard:
        maxValue = 7;
        break;
      case GameDifficult.godLevel:
        maxValue = 9;
        break;
    }
    final random = Random();
    final randomNumber = random.nextInt(maxValue);
    final image = await rootBundle.load(aliensAssets[randomNumber].assetPath);
    return AssetData(image, aliensAssets[randomNumber].name);
  }
}
