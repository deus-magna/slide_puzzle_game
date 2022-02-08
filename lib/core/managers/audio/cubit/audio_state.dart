part of 'audio_cubit.dart';

class AudioState extends Equatable {
  const AudioState({required this.ambientPlayer, required this.isMuted});

  final AudioPlayer ambientPlayer;
  final bool isMuted;

  @override
  List<Object> get props => [ambientPlayer, isMuted];
}
