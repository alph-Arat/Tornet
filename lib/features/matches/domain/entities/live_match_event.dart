import 'package:equatable/equatable.dart';

class LiveMatchEvent extends Equatable {
  final String matchApiId;
  final int matchStatus;
  final List<int> homeTeamData;
  final List<int> awayTeamData;
  final int kickoffTimestamp;

  const LiveMatchEvent({
    required this.matchApiId,
    required this.matchStatus,
    required this.homeTeamData,
    required this.awayTeamData,
    required this.kickoffTimestamp,
  });

  int get homeScore => homeTeamData[0];
  int get homeHalftimeScore => homeTeamData[1];
  int get homeRedCards => homeTeamData[2];
  int get homeYellowCards => homeTeamData[3];
  int get homeCorners => homeTeamData[4];
  int get homeOvertimeScore => homeTeamData[5];
  int get homePenaltyScore => homeTeamData[6];

  int get awayScore => awayTeamData[0];
  int get awayHalftimeScore => awayTeamData[1];
  int get awayRedCards => awayTeamData[2];
  int get awayYellowCards => awayTeamData[3];
  int get awayCorners => awayTeamData[4];
  int get awayOvertimeScore => awayTeamData[5];
  int get awayPenaltyScore => awayTeamData[6];

  String get matchStatusDescription {
    switch (matchStatus) {
      case 0:
        return 'Abnormal';
      case 1:
        return 'Not started';
      case 2:
        return 'First half';
      case 3:
        return 'Half-time';
      case 4:
        return 'Second half';
      case 5:
        return 'Overtime';
      case 6:
        return 'Overtime (deprecated)';
      case 7:
        return 'Penalty shoot-out';
      case 8:
        return 'End';
      case 9:
        return 'Delay';
      case 10:
        return 'Interrupted';
      case 11:
        return 'Cut in half';
      case 12:
        return 'Canceled';
      case 13:
        return 'To be determined';
      default:
        return 'Unknown';
    }
  }

  @override
  List<Object?> get props => [
        matchApiId,
        matchStatus,
        homeTeamData,
        awayTeamData,
        kickoffTimestamp,
      ];
}
