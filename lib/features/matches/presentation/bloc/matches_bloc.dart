import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tornet_assignment/features/matches/domain/usecases/get_matches_by_day.dart';
import 'package:tornet_assignment/features/matches/presentation/bloc/matches_event.dart';
import 'package:tornet_assignment/features/matches/presentation/bloc/matches_state.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  final GetMatchesByDay getMatchesByDay;

  MatchesBloc({required this.getMatchesByDay}) : super(MatchesInitial()) {
    on<FetchMatchesByDay>(_onFetchMatchesByDay);
  }

  Future<void> _onFetchMatchesByDay(
    FetchMatchesByDay event,
    Emitter<MatchesState> emit,
  ) async {
    emit(MatchesLoading());

    final result = await getMatchesByDay(
      GetMatchesByDayParams(
        token: event.token,
        date: event.date,
      ),
    );

    result.fold(
      (failure) => emit(const MatchesError(message: 'Failed to fetch matches')),
      (data) => emit(MatchesLoaded(
        matchesByDay: data.matchesByDay,
        matchDays: data.matchDays,
      )),
    );
  }
}
