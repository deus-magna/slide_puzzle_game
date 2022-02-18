import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
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
    final assetData = await _getAssetData(gameDifficult);
    final input = List<int>.from(assetData);
    final sources = await _splitImage(input, gameDifficult.size);

    emit(DifficultLoaded(
      GameParams(
        assetData: assetData,
        gameDifficult: gameDifficult,
        assets: sources,
      ),
    ));
  }

  Future<Uint8List> _getAssetData(GameDifficult difficult) async {
    final bytes = await _bytesFromAsset(difficult);
    final mibiByte = bytes.buffer.asUint8List();
    return mibiByte;
  }

  Future<ByteData> _bytesFromAsset(GameDifficult difficult) async {
    switch (difficult) {
      case GameDifficult.easy:
        print('Inicia el read');
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
