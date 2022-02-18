import 'package:equatable/equatable.dart';

const aliensAssets = <AlienAsset>[
  AlienAsset('assets/img/tiles/uan.png', 'uan'),
  AlienAsset('assets/img/tiles/balloopus.png', 'balloopus'),
  AlienAsset('assets/img/tiles/lemhost.png', 'lemhost'),
  AlienAsset('assets/img/tiles/inky.png', 'inky'),
  AlienAsset('assets/img/tiles/ubbi.png', 'ubbi'),
  AlienAsset('assets/img/tiles/biglaught.png', 'biglaught'),
  AlienAsset('assets/img/tiles/bathead.png', 'bathead'),
  AlienAsset('assets/img/tiles/tentamoon.png', 'tentamoon'),
  AlienAsset('assets/img/tiles/flamfy.png', 'flamfy'),
];

class AlienAsset extends Equatable {
  const AlienAsset(this.assetPath, this.name);

  final String assetPath;
  final String name;

  @override
  List<Object?> get props => [assetPath, name];
}
