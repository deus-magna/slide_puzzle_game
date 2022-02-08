import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit(AudioPlayer ambientPlayer)
      : super(AudioState(ambientPlayer: ambientPlayer, isMuted: false));

  AudioPlayer get ambientPlayer => state.ambientPlayer;

  void playMenuMusic() => ambientPlayer
    ..setAsset('assets/audio/space_age.mp3')
    ..setLoopMode(LoopMode.all)
    ..setVolume(state.isMuted ? 0.0 : 0.2)
    ..play();

  void playGameMusic() => ambientPlayer
    ..setAsset('assets/audio/space_chillout.mp3')
    ..setLoopMode(LoopMode.all)
    ..setVolume(state.isMuted ? 0.0 : 0.2)
    ..play();

  void stop() => ambientPlayer.stop();

  void toogleMusic() {
    if (ambientPlayer.volume > 0) {
      ambientPlayer.setVolume(0);
      emit(AudioState(ambientPlayer: ambientPlayer, isMuted: true));
    } else {
      ambientPlayer.setVolume(0.2);
      emit(AudioState(ambientPlayer: ambientPlayer, isMuted: false));
    }
  }
}
