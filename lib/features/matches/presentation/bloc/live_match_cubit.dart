import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tornet_assignment/features/matches/data/datasources/websocket_service.dart';
import 'package:tornet_assignment/features/matches/domain/entities/live_match_event.dart';

// State
class LiveMatchState extends Equatable {
  final Map<String, LiveMatchEvent> liveMatches;
  final bool isConnected;

  const LiveMatchState({
    this.liveMatches = const {},
    this.isConnected = false,
  });

  LiveMatchState copyWith({
    Map<String, LiveMatchEvent>? liveMatches,
    bool? isConnected,
  }) {
    return LiveMatchState(
      liveMatches: liveMatches ?? this.liveMatches,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object?> get props => [liveMatches, isConnected];
}

// Cubit
class LiveMatchCubit extends Cubit<LiveMatchState> {
  final WebSocketService _webSocketService;
  StreamSubscription<LiveMatchEvent>? _liveMatchSubscription;
  StreamSubscription<bool>? _connectionSubscription;

  LiveMatchCubit(this._webSocketService) : super(const LiveMatchState()) {
    _init();
  }

  void _init() {
    _liveMatchSubscription = _webSocketService.liveMatchStream.listen(
      (event) {
        final updatedMatches = Map<String, LiveMatchEvent>.from(state.liveMatches);
        updatedMatches[event.matchApiId] = event;
        emit(state.copyWith(liveMatches: updatedMatches));
      },
    );

    _connectionSubscription = _webSocketService.connectionStateStream.listen(
      (isConnected) {
        emit(state.copyWith(isConnected: isConnected));
      },
    );
  }

  void connect() {
    _webSocketService.connect();
  }

  void disconnect() {
    _webSocketService.disconnect();
  }

  LiveMatchEvent? getMatchUpdate(String matchApiId) {
    return state.liveMatches[matchApiId];
  }

  @override
  Future<void> close() {
    _liveMatchSubscription?.cancel();
    _connectionSubscription?.cancel();
    _webSocketService.dispose();
    return super.close();
  }
}
