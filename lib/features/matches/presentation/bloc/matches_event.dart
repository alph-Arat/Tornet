import 'package:equatable/equatable.dart';

abstract class MatchesEvent extends Equatable {
  const MatchesEvent();

  @override
  List<Object?> get props => [];
}

class FetchMatchesByDay extends MatchesEvent {
  final String token;
  final String? date;

  const FetchMatchesByDay({
    required this.token,
    this.date,
  });

  @override
  List<Object?> get props => [token, date];
}
