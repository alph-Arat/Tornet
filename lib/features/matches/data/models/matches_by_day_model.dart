import 'package:tornet_assignment/features/matches/data/models/competition_matches_model.dart';
import 'package:tornet_assignment/features/matches/data/models/match_model.dart';
import 'package:tornet_assignment/features/matches/domain/entities/matches_by_day.dart';

class MatchesByDayModel extends MatchesByDay {
  const MatchesByDayModel({
    required super.date,
    required super.favClubMatches,
    required super.competitions,
  });

  factory MatchesByDayModel.fromJson(Map<String, dynamic> json) {
    return MatchesByDayModel(
      date: json['date'] ?? '',
      favClubMatches: (json['favClubMatches'] as List<dynamic>?)
              ?.map((match) => MatchModel.fromJson(match))
              .toList() ??
          [],
      competitions: (json['competitions'] as List<dynamic>?)
              ?.map((comp) => CompetitionMatchesModel.fromJson(comp))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'favClubMatches': favClubMatches
          .map((match) => (match as MatchModel).toJson())
          .toList(),
      'competitions': competitions
          .map((comp) => (comp as CompetitionMatchesModel).toJson())
          .toList(),
    };
  }
}
