part of 'difficult_cubit.dart';

abstract class DifficultState extends Equatable {
  const DifficultState();

  @override
  List<Object> get props => [];
}

class DifficultInitial extends DifficultState {}

class DifficultLoading extends DifficultState {}

class DifficultLoaded extends DifficultState {
  const DifficultLoaded(this.gameParams);

  final GameParams gameParams;

  @override
  List<Object> get props => [gameParams];
}
