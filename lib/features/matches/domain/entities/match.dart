import 'package:equatable/equatable.dart';
import 'package:tornet_assignment/features/matches/domain/entities/competition.dart';
import 'package:tornet_assignment/features/matches/domain/entities/team.dart';

class Match extends Equatable {
  final String id;
  final String? apiId;
  final Team homeTeam;
  final Team awayTeam;
  final String matchStatusDescription;
  final String matchTime;
  final String? matchDay;
  final String? matchDate;
  final Competition? competition;

  const Match({
    required this.id,
    this.apiId,
    required this.homeTeam,
    required this.awayTeam,
    required this.matchStatusDescription,
    required this.matchTime,
    this.matchDay,
    this.matchDate,
    this.competition,
  });

  @override
  List<Object?> get props => [
        id,
        apiId,
        homeTeam,
        awayTeam,
        matchStatusDescription,
        matchTime,
        matchDay,
        matchDate,
        competition,
      ];
}
