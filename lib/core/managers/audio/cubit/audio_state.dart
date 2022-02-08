part of 'audio_cubit.dart';

class AudioState extends Equatable {
  const AudioState(this.ambientPlayer);

  final AudioPlayer ambientPlayer;

  @override
  List<Object> get props => [ambientPlayer];
}
