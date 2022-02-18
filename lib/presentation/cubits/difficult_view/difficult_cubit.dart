import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
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
    switch (difficult) {
      case GameDifficult.easy:
        return _loadEasyAlien();
      case GameDifficult.medimum:
        return _loadEasyAlien();
      // return rootBundle.load('assets/img/tiles/inky/inky.png');
      case GameDifficult.hard:
        return _loadEasyAlien();
      // return rootBundle.load('assets/img/tiles/ubbi/ubbi.png');
      case GameDifficult.godLevel:
        return _loadEasyAlien();
      // return rootBundle.load('assets/img/tiles/flamfy/flamfy.png');
    }
  }

  Future<AssetData> _loadEasyAlien() async {
    final random = Random();
    final randomNumber = random.nextInt(3);
    switch (randomNumber) {
      case 0:
        final image = await rootBundle.load('assets/img/tiles/balloopus.png');
        return AssetData(image, 'balloopus');
      case 1:
        final image = await rootBundle.load('assets/img/tiles/uan/uan.png');
        return AssetData(image, 'uan');
      default:
        final image = await rootBundle.load('assets/img/tiles/lemhost.png');
        return AssetData(image, 'lemhost');
    }
  }
}
