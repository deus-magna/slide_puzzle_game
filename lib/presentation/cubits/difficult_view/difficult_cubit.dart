import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:slide_puzzle_game/data/models/game_params.dart';
import 'package:slide_puzzle_game/presentation/cubits/game_view/game_cubit.dart';

part 'difficult_state.dart';

class DifficultCubit extends Cubit<DifficultState> {
  DifficultCubit() : super(DifficultInitial());

  Future<void> loadAssets(GameDifficult gameDifficult) async {
    emit(DifficultLoading());
    final assetData = await _getAssetData(gameDifficult);
    emit(DifficultLoaded(
      GameParams(assetData: assetData, gameDifficult: gameDifficult),
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
