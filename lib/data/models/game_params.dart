import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:slide_puzzle_game/presentation/cubits/game/game_cubit.dart';

class GameParams extends Equatable {
  const GameParams({required this.assetData, required this.gameDifficult});

  final Uint8List assetData;
  final GameDifficult gameDifficult;

  @override
  List<Object?> get props => [assetData, gameDifficult];
}
