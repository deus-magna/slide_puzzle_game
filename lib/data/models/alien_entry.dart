import 'package:equatable/equatable.dart';

class AlienEntry extends Equatable {
  const AlienEntry({
    required this.name,
    required this.wieght,
    required this.height,
    required this.nature,
    required this.description,
    required this.src,
    required this.isSolved,
  });

  final String name;
  final String wieght;
  final String height;
  final String nature;
  final String description;
  final String src;
  final bool isSolved;

  @override
  List<Object?> get props => [name, wieght, height, nature, description];
}
