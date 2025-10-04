import 'package:tornet_assignment/features/matches/domain/entities/team.dart';

class TeamModel extends Team {
  const TeamModel({
    required super.id,
    required super.name,
    required super.logo,
    super.score,
    super.shirt,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      score: json['score'] != null ? List<int>.from(json['score']) : null,
      shirt: json['shirt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'score': score,
      'shirt': shirt,
    };
  }
}
