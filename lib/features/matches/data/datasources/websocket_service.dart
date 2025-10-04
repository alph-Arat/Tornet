import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:tornet_assignment/features/matches/domain/entities/live_match_event.dart';
import 'package:tornet_assignment/features/matches/data/models/live_match_event_model.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  final _liveMatchController = StreamController<LiveMatchEvent>.broadcast();
  final _connectionStateController = StreamController<bool>.broadcast();

  Stream<LiveMatchEvent> get liveMatchStream => _liveMatchController.stream;
  Stream<bool> get connectionStateStream => _connectionStateController.stream;

  void connect() {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse(
          'wss://mqtt.staging.torliga.com/app/4bae652d93c285868d11?protocol=7&client=js&version=4.3.1&flash=false',
        ),
      );

      _connectionStateController.add(true);

      _subscribe();
      _channel!.stream.listen(
        (message) {
          _handleMessage(message);
        },
        onError: (error) {
          _connectionStateController.add(false);
        },
        onDone: () {
          _connectionStateController.add(false);
        },
      );
    } catch (e) {
      _connectionStateController.add(false);
    }
  }

  void _subscribe() {
    final subscribeMessage = jsonEncode({
      'event': 'pusher:subscribe',
      'data': {
        'channel': 'thesports-football.matchs',
      },
    });

    _channel?.sink.add(subscribeMessage);
  }

  void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message);

      if (data.containsKey('score-event')) {
        final scoreEvents = data['score-event'] as List;
        for (var event in scoreEvents) {
          if (event is List && event.isNotEmpty) {
            try {
              final liveEvent = LiveMatchEventModel.fromJson(event).toEntity();
              _liveMatchController.add(liveEvent);
            } on Exception {
              // Skip malformed event data
            }
          }
        }
      } else if (data['event'] == 'score-event') {
        if (data['data'] != null) {
          var eventData = data['data'];

          if (eventData is String) {
            eventData = jsonDecode(eventData);
          }

          if (eventData is List && eventData.isNotEmpty) {
            try {
              final liveEvent = LiveMatchEventModel.fromJson(eventData).toEntity();
              _liveMatchController.add(liveEvent);
            } on Exception {
              // Skip malformed event data
            }
          } else if (eventData is Map && eventData.containsKey('score-event')) {
            final scoreEvents = eventData['score-event'] as List;
            for (var event in scoreEvents) {
              if (event is List && event.isNotEmpty) {
                try {
                  final liveEvent = LiveMatchEventModel.fromJson(event).toEntity();
                  _liveMatchController.add(liveEvent);
                } on Exception {
                  // Skip malformed event data
                }
              }
            }
          }
        }
      }
    } on Exception {
      // Skip non-JSON or malformed messages
    }
  }

  void disconnect() {
    _channel?.sink.close();
    _connectionStateController.add(false);
  }

  void dispose() {
    disconnect();
    _liveMatchController.close();
    _connectionStateController.close();
  }
}
