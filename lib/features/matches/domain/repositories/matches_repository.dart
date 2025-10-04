import 'package:dartz/dartz.dart';
import 'package:tornet_assignment/core/errors/failures.dart';
import 'package:tornet_assignment/features/matches/domain/entities/match_day.dart';
import 'package:tornet_assignment/features/matches/domain/entities/matches_by_day.dart';

abstract class MatchesRepository {
  Future<Either<Failure, List<MatchesByDay>>> getMatchesByDay({
    required String token,
    String? date,
  });

  Future<Either<Failure, List<MatchDay>>> getMatchDays({
    required String token,
  });
}
