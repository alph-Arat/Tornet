import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tornet_assignment/core/errors/failures.dart';
import 'package:tornet_assignment/core/usecases/usecase.dart';
import 'package:tornet_assignment/features/matches/domain/entities/match_day.dart';
import 'package:tornet_assignment/features/matches/domain/entities/matches_by_day.dart';
import 'package:tornet_assignment/features/matches/domain/repositories/matches_repository.dart';

class GetMatchesByDay implements UseCase<MatchesByDayResult, GetMatchesByDayParams> {
  final MatchesRepository repository;

  GetMatchesByDay(this.repository);

  @override
  Future<Either<Failure, MatchesByDayResult>> call(GetMatchesByDayParams params) async {
    final matchesResult = await repository.getMatchesByDay(
      token: params.token,
      date: params.date,
    );

    return matchesResult.fold(
      (failure) => Left(failure),
      (matches) async {
        final matchDaysResult = await repository.getMatchDays(token: params.token);
        return matchDaysResult.fold(
          (failure) => Left(failure),
          (matchDays) => Right(MatchesByDayResult(
            matchesByDay: matches,
            matchDays: matchDays,
          )),
        );
      },
    );
  }
}

class GetMatchesByDayParams extends Equatable {
  final String token;
  final String? date;

  const GetMatchesByDayParams({
    required this.token,
    this.date,
  });

  @override
  List<Object?> get props => [token, date];
}

class MatchesByDayResult extends Equatable {
  final List<MatchesByDay> matchesByDay;
  final List<MatchDay> matchDays;

  const MatchesByDayResult({
    required this.matchesByDay,
    required this.matchDays,
  });

  @override
  List<Object?> get props => [matchesByDay, matchDays];
}
