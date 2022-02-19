part of 'audio_cubit.dart';

class AudioState extends Equatable {
  const AudioState({
    required this.ambientPlayer,
    required this.soundEffectsPlayer,
    required this.isAmbientMusicMuted,
    required this.isSoundEffectsMuted,
  });

  final AudioPlayer ambientPlayer;
  final AudioPlayer soundEffectsPlayer;
  final bool isAmbientMusicMuted;
  final bool isSoundEffectsMuted;

  @override
  List<Object> get props => [
        ambientPlayer,
        isAmbientMusicMuted,
        isSoundEffectsMuted,
        soundEffectsPlayer
      ];
}
