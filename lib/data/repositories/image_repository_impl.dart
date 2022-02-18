import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as imglib;
import 'package:slide_puzzle_game/domain/repositories/image_repository.dart';

class ImageParams {
  ImageParams(this.input, this.size);

  final List<int> input;
  final int size;
}

class ImageRepositoryImpl extends ImageRepository {
  @override
  Future<List<Uint8List>> splitImage(List<int> input, int size) async {
    final output = await compute(split, ImageParams(input, size));
    return Future.value(output);
  }

  Future<List<Uint8List>> split(ImageParams params) {
    // convert image to image from image package
    final image = imglib.decodeImage(params.input);

    var x = 0, y = 0;
    final width = (image!.width / params.size).round();
    final height = (image.height / params.size).round();

    // split image to parts
    final parts = <imglib.Image>[];
    for (var i = 0; i < params.size; i++) {
      for (var j = 0; j < params.size; j++) {
        parts.add(imglib.copyCrop(image, x, y, width, height));
        x += width;
      }
      x = 0;
      y += height;
    }

    // convert image from image package to Image Widget to display
    final output = <Uint8List>[];
    for (final img in parts) {
      final image8List = Uint8List.fromList(imglib.encodeJpg(img));
      output.add(image8List);
    }

    return Future.value(output);
  }
}
