import 'package:equatable/equatable.dart';

class MatchDay extends Equatable {
  final String id;
  final String date;
  final String day;
  final bool isFuture;

  const MatchDay({
    required this.id,
    required this.date,
    required this.day,
    required this.isFuture,
  });

  @override
  List<Object?> get props => [id, date, day, isFuture];
}
