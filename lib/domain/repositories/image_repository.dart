// ignore_for_file: one_member_abstracts

import 'dart:typed_data';

abstract class ImageRepository {
  Future<List<Uint8List>> splitImage(List<int> input, int size);
}
