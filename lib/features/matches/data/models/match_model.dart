import 'package:tornet_assignment/features/matches/data/models/competition_model.dart';
import 'package:tornet_assignment/features/matches/data/models/team_model.dart';
import 'package:tornet_assignment/features/matches/domain/entities/match.dart';

class MatchModel extends Match {
  const MatchModel({
    required super.id,
    super.apiId,
    required super.homeTeam,
    required super.awayTeam,
    required super.matchStatusDescription,
    required super.matchTime,
    super.matchDay,
    super.matchDate,
    super.competition,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id']?.toString() ?? '',
      apiId: json['api_id']?.toString(),
      homeTeam: TeamModel.fromJson(json['home_team'] ?? {}),
      awayTeam: TeamModel.fromJson(json['away_team'] ?? {}),
      matchStatusDescription: json['match_status_description'] ?? '',
      matchTime: json['match_time'] ?? '',
      matchDay: json['match_day'],
      matchDate: json['match_date'],
      competition: json['competition'] != null
          ? CompetitionModel.fromJson(json['competition'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'home_team': (homeTeam as TeamModel).toJson(),
      'away_team': (awayTeam as TeamModel).toJson(),
      'match_status_description': matchStatusDescription,
      'match_time': matchTime,
      'match_day': matchDay,
      'match_date': matchDate,
      'competition': competition != null
          ? (competition as CompetitionModel).toJson()
          : null,
    };
  }
}
