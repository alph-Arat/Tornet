import 'package:tornet_assignment/features/matches/domain/entities/competition.dart';

class CompetitionModel extends Competition {
  const CompetitionModel({
    required super.id,
    required super.name,
    required super.image,
  });

  factory CompetitionModel.fromJson(Map<String, dynamic> json) {
    return CompetitionModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? json['logo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
