part of 'audio_cubit.dart';

class AudioState extends Equatable {
  const AudioState({
    required this.ambientPlayer,
    required this.isAmbientMusicMuted,
    required this.isSoundEffectsMuted,
  });

  final AudioPlayer ambientPlayer;
  final bool isAmbientMusicMuted;
  final bool isSoundEffectsMuted;

  @override
  List<Object> get props =>
      [ambientPlayer, isAmbientMusicMuted, isSoundEffectsMuted];
}
