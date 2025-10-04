import 'package:equatable/equatable.dart';
import 'package:tornet_assignment/features/matches/domain/entities/competition_matches.dart';
import 'package:tornet_assignment/features/matches/domain/entities/match.dart';

class MatchesByDay extends Equatable {
  final String date;
  final List<Match> favClubMatches;
  final List<CompetitionMatches> competitions;

  const MatchesByDay({
    required this.date,
    required this.favClubMatches,
    required this.competitions,
  });

  @override
  List<Object?> get props => [date, favClubMatches, competitions];
}
