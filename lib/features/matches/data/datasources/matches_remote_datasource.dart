import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tornet_assignment/core/constants/api_constants.dart';
import 'package:tornet_assignment/features/matches/data/models/match_day_model.dart';
import 'package:tornet_assignment/features/matches/data/models/matches_by_day_model.dart';

abstract class MatchesRemoteDataSource {
  Future<List<MatchesByDayModel>> getMatchesByDay({
    required String token,
    String? date,
  });

  Future<List<MatchDayModel>> getMatchDays({
    required String token,
  });
}

class MatchesRemoteDataSourceImpl implements MatchesRemoteDataSource {
  final http.Client client;

  MatchesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MatchesByDayModel>> getMatchesByDay({
    required String token,
    String? date,
  }) async {
    final queryParams = date != null ? '?date=$date' : '';
    final url = Uri.parse('${ApiConstants.baseUrl}/v2/matches/byDay$queryParams');

    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );


    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<dynamic> data = responseData['data'] ?? [];

      return data.map((item) => MatchesByDayModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch matches');
    }
  }

  @override
  Future<List<MatchDayModel>> getMatchDays({
    required String token,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/v2/matches/byDay');

    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<dynamic> matchDays = responseData['match_days'] ?? [];

      return matchDays.map((item) => MatchDayModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch match days');
    }
  }
}
