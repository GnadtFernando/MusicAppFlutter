import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_app_flutter/core/services/audio_player_service_impl.dart';
import 'package:music_app_flutter/core/errors/exceptions.dart' as message;

class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  late MockAudioPlayer mockAudioPlayer;
  late AudioPlayerServiceImpl audioPlayerServiceImpl;

  setUp(() {
    mockAudioPlayer = MockAudioPlayer();
    audioPlayerServiceImpl = AudioPlayerServiceImpl(mockAudioPlayer);
  });

  test('Should get current music position', () async {
    when(() => mockAudioPlayer.getCurrentPosition()).thenAnswer(
      (_) => Future.value(
        const Duration(seconds: 10),
      ),
    );

    final position = await audioPlayerServiceImpl.getCurrentPosition;

    verify(() => mockAudioPlayer.getCurrentPosition()).called(1);
    expect(position, equals(10));
  });

  test('Should get audio complete stream', () async {
    final mockStreamController = StreamController<Duration>();
    when(() => mockAudioPlayer.onPositionChanged).thenAnswer(
      (_) => mockStreamController.stream,
    );

    final positionStream = audioPlayerServiceImpl.getPositionStream();

    verify(() => mockAudioPlayer.onPositionChanged).called(1);
    expect(
      positionStream,
      equals(mockStreamController.stream),
    );
  });

  group(
    'Pause Music',
    () {
      test('Should successfully pause music', () async {
        when(() => mockAudioPlayer.pause()).thenAnswer((_) => Future.value());

        await audioPlayerServiceImpl.pauseMusic();
        verify(() => mockAudioPlayer.pause()).called(1);
      });

      test(
        'Should fail on pause music',
        () {
          when(() => mockAudioPlayer.pause()).thenThrow(Exception());

          final futurePause = audioPlayerServiceImpl.pauseMusic();

          verify(() => mockAudioPlayer.pause()).called(1);
          expect(futurePause, throwsA(isA<message.AudioPlayerException>()));
        },
      );
    },
  );
}
