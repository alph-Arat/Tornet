import 'package:tornet_assignment/features/matches/domain/entities/live_match_event.dart';

class LiveMatchEventModel extends LiveMatchEvent {
  const LiveMatchEventModel({
    required super.matchApiId,
    required super.matchStatus,
    required super.homeTeamData,
    required super.awayTeamData,
    required super.kickoffTimestamp,
  });

  factory LiveMatchEventModel.fromJson(List<dynamic> json) {
    return LiveMatchEventModel(
      matchApiId: json[0].toString(),
      matchStatus: json[1] as int,
      homeTeamData: List<int>.from(json[2] as List),
      awayTeamData: List<int>.from(json[3] as List),
      kickoffTimestamp: json[4] as int,
    );
  }

  LiveMatchEvent toEntity() {
    return LiveMatchEvent(
      matchApiId: matchApiId,
      matchStatus: matchStatus,
      homeTeamData: homeTeamData,
      awayTeamData: awayTeamData,
      kickoffTimestamp: kickoffTimestamp,
    );
  }
}
