import 'package:tornet_assignment/features/matches/data/models/competition_model.dart';
import 'package:tornet_assignment/features/matches/data/models/match_model.dart';
import 'package:tornet_assignment/features/matches/domain/entities/competition_matches.dart';

class CompetitionMatchesModel extends CompetitionMatches {
  const CompetitionMatchesModel({
    required super.competition,
    required super.matches,
  });

  factory CompetitionMatchesModel.fromJson(Map<String, dynamic> json) {
    return CompetitionMatchesModel(
      competition: CompetitionModel.fromJson(json['competition'] ?? {}),
      matches: (json['matches'] as List<dynamic>?)
              ?.map((match) => MatchModel.fromJson(match))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'competition': (competition as CompetitionModel).toJson(),
      'matches': matches.map((match) => (match as MatchModel).toJson()).toList(),
    };
  }
}
