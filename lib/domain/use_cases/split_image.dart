import 'dart:typed_data';

import 'package:slide_puzzle_game/domain/repositories/image_repository.dart';

class SplitImage {
  SplitImage(this.imageRepository);

  final ImageRepository imageRepository;

  Future<List<Uint8List>> call(List<int> input, int size) async =>
      imageRepository.splitImage(input, size);
}
