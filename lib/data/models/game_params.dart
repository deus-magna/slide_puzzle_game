import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:slide_puzzle_game/presentation/cubits/game_cubit/game_cubit.dart';

class GameParams extends Equatable {
  const GameParams({
    required this.assetData,
    required this.gameDifficult,
    required this.assets,
    required this.alienName,
  });

  final Uint8List assetData;
  final GameDifficult gameDifficult;
  final List<Uint8List> assets;
  final String alienName;

  @override
  List<Object?> get props => [assetData, gameDifficult, assets, alienName];
}

class AssetData extends Equatable {
  const AssetData(this.image, this.name);

  final ByteData image;
  final String name;

  @override
  List<Object?> get props => [image, name];
}
