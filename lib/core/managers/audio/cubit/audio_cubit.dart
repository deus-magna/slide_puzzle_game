import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit(AudioPlayer ambientPlayer)
      : super(AudioState(
          ambientPlayer: ambientPlayer,
          isAmbientMusicMuted: false,
          isSoundEffectsMuted: false,
        ));

  AudioPlayer get ambientPlayer => state.ambientPlayer;

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

  void toogleSoudEffects() {
    if (state.isSoundEffectsMuted) {
      emit(AudioState(
          ambientPlayer: ambientPlayer,
          isAmbientMusicMuted: state.isAmbientMusicMuted,
          isSoundEffectsMuted: false));
    } else {
      emit(AudioState(
          ambientPlayer: ambientPlayer,
          isAmbientMusicMuted: state.isAmbientMusicMuted,
          isSoundEffectsMuted: true));
    }
  }

  void toogleMusic() {
    if (ambientPlayer.volume > 0) {
      ambientPlayer.setVolume(0);
      emit(AudioState(
          ambientPlayer: ambientPlayer,
          isAmbientMusicMuted: true,
          isSoundEffectsMuted: state.isSoundEffectsMuted));
    } else {
      ambientPlayer.setVolume(0.2);
      emit(AudioState(
          ambientPlayer: ambientPlayer,
          isAmbientMusicMuted: false,
          isSoundEffectsMuted: state.isSoundEffectsMuted));
    }
  }
}
