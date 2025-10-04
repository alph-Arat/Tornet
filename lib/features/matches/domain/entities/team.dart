import 'package:equatable/equatable.dart';

class Team extends Equatable {
  final String id;
  final String name;
  final String logo;
  final List<int>? score;
  final String? shirt;

  const Team({
    required this.id,
    required this.name,
    required this.logo,
    this.score,
    this.shirt,
  });

  @override
  List<Object?> get props => [id, name, logo, score, shirt];
}
