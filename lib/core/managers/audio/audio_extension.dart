import 'dart:async';

import 'package:just_audio/just_audio.dart';

extension AudioPlayerExtension on AudioPlayer {
  Future<void> replay() async {
    await stop();
    await seek(null);
    unawaited(play());
  }
}
