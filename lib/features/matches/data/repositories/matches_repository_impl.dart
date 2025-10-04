import 'package:dartz/dartz.dart';
import 'package:tornet_assignment/core/errors/failures.dart';
import 'package:tornet_assignment/features/matches/data/datasources/matches_remote_datasource.dart';
import 'package:tornet_assignment/features/matches/domain/entities/match_day.dart';
import 'package:tornet_assignment/features/matches/domain/entities/matches_by_day.dart';
import 'package:tornet_assignment/features/matches/domain/repositories/matches_repository.dart';

class MatchesRepositoryImpl implements MatchesRepository {
  final MatchesRemoteDataSource remoteDataSource;

  MatchesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MatchesByDay>>> getMatchesByDay({
    required String token,
    String? date,
  }) async {
    try {
      final matches = await remoteDataSource.getMatchesByDay(
        token: token,
        date: date,
      );
      return Right(matches);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MatchDay>>> getMatchDays({
    required String token,
  }) async {
    try {
      final matchDays = await remoteDataSource.getMatchDays(token: token);
      return Right(matchDays);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
