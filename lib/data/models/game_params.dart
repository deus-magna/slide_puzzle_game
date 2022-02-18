import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:slide_puzzle_game/presentation/cubits/game_view/game_cubit.dart';

class GameParams extends Equatable {
  const GameParams({
    required this.assetData,
    required this.gameDifficult,
    required this.assets,
  });

  final Uint8List assetData;
  final GameDifficult gameDifficult;
  final List<Uint8List> assets;

  @override
  List<Object?> get props => [assetData, gameDifficult, assets];
}
