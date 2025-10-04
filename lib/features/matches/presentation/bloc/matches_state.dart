import 'package:equatable/equatable.dart';
import 'package:tornet_assignment/features/matches/domain/entities/match_day.dart';
import 'package:tornet_assignment/features/matches/domain/entities/matches_by_day.dart';

abstract class MatchesState extends Equatable {
  const MatchesState();

  @override
  List<Object> get props => [];
}

class MatchesInitial extends MatchesState {}

class MatchesLoading extends MatchesState {}

class MatchesLoaded extends MatchesState {
  final List<MatchesByDay> matchesByDay;
  final List<MatchDay> matchDays;

  const MatchesLoaded({
    required this.matchesByDay,
    required this.matchDays,
  });

  @override
  List<Object> get props => [matchesByDay, matchDays];
}

class MatchesError extends MatchesState {
  final String message;

  const MatchesError({required this.message});

  @override
  List<Object> get props => [message];
}
