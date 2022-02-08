import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit(AudioPlayer ambientPlayer) : super(AudioState(ambientPlayer));

  AudioPlayer get ambientPlayer => state.ambientPlayer;

  void play() {
    ambientPlayer
      ..setLoopMode(LoopMode.all)
      ..setVolume(0.2)
      ..play();
  }

  void setAsset(String assetPath) {
    ambientPlayer.setAsset(assetPath);
  }
}
