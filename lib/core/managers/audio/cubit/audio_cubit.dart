import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit(AudioPlayer ambientPlayer, AudioPlayer soundEffectsPlayer)
      : super(AudioState(
          ambientPlayer: ambientPlayer,
          soundEffectsPlayer: soundEffectsPlayer,
          isAmbientMusicMuted: false,
          isSoundEffectsMuted: false,
        ));

  AudioPlayer get ambientPlayer => state.ambientPlayer;
  AudioPlayer get soundEffectsPlayer => state.soundEffectsPlayer;

  void playMenuMusic() => ambientPlayer
    ..setAsset('assets/audio/space_age.mp3')
    ..setLoopMode(LoopMode.all)
    ..setVolume(state.isAmbientMusicMuted ? 0.0 : 0.2)
    ..play();

  void playGameMusic() => ambientPlayer
    ..setAsset('assets/audio/space_chillout.mp3')
    ..setLoopMode(LoopMode.all)
    ..setVolume(state.isAmbientMusicMuted ? 0.0 : 0.2)
    ..play();

  void stop() => ambientPlayer.stop();

  Future<void> win() async {
    await soundEffectsPlayer.setAsset('assets/audio/winning_notification.mp3');
    await soundEffectsPlayer.setVolume(state.isSoundEffectsMuted ? 0.0 : 1);
    await soundEffectsPlayer.stop();
    await soundEffectsPlayer.seek(null);
    unawaited(soundEffectsPlayer.play());
  }

  void toogleSoudEffects() {
    if (state.isSoundEffectsMuted) {
      emit(AudioState(
          ambientPlayer: ambientPlayer,
          soundEffectsPlayer: soundEffectsPlayer,
          isAmbientMusicMuted: state.isAmbientMusicMuted,
          isSoundEffectsMuted: false));
    } else {
      emit(AudioState(
          ambientPlayer: ambientPlayer,
          soundEffectsPlayer: soundEffectsPlayer,
          isAmbientMusicMuted: state.isAmbientMusicMuted,
          isSoundEffectsMuted: true));
    }
  }

  void toogleMusic() {
    if (ambientPlayer.volume > 0) {
      ambientPlayer.setVolume(0);
      emit(AudioState(
          ambientPlayer: ambientPlayer,
          soundEffectsPlayer: soundEffectsPlayer,
          isAmbientMusicMuted: true,
          isSoundEffectsMuted: state.isSoundEffectsMuted));
    } else {
      ambientPlayer.setVolume(0.2);
      emit(AudioState(
          ambientPlayer: ambientPlayer,
          soundEffectsPlayer: soundEffectsPlayer,
          isAmbientMusicMuted: false,
          isSoundEffectsMuted: state.isSoundEffectsMuted));
    }
  }
}
