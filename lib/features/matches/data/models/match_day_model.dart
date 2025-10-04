import 'package:tornet_assignment/features/matches/domain/entities/match_day.dart';

class MatchDayModel extends MatchDay {
  const MatchDayModel({
    required super.id,
    required super.date,
    required super.day,
    required super.isFuture,
  });

  factory MatchDayModel.fromJson(Map<String, dynamic> json) {
    return MatchDayModel(
      id: json['id']?.toString() ?? '',
      date: json['date'] ?? '',
      day: json['day'] ?? '',
      isFuture: json['is_future'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'day': day,
      'is_future': isFuture,
    };
  }
}
