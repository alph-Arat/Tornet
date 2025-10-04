import 'package:equatable/equatable.dart';
import 'package:tornet_assignment/features/matches/domain/entities/competition.dart';
import 'package:tornet_assignment/features/matches/domain/entities/match.dart';

class CompetitionMatches extends Equatable {
  final Competition competition;
  final List<Match> matches;

  const CompetitionMatches({
    required this.competition,
    required this.matches,
  });

  @override
  List<Object?> get props => [competition, matches];
}
