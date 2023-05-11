import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:music_app_flutter/core/services/audio_player_service.dart';
import 'package:music_app_flutter/core/errors/exceptions.dart' as message;

class AudioPlayerServiceImpl extends GetxService implements AudioPlayerService {
  final AudioPlayer audioPlayer;

  AudioPlayerServiceImpl(this.audioPlayer);

  @override
  Future<int> get getCurrentPosition async {
    try {
      final position = await audioPlayer.getCurrentPosition();

      return position?.inSeconds ?? 0;
    } catch (e, s) {
      log('Erro ao pegar posição da musica', error: e, stackTrace: s);
      throw message.AudioPlayerException(
        message: 'Erro ao pegar posição da musica',
      );
    }
  }

  @override
  Stream<void> onAudioComplete() {
    return audioPlayer.onPlayerComplete;
  }

  @override
  Stream<Duration> getPositionStream() {
    return audioPlayer.onPositionChanged;
  }

  @override
  Future<void> pauseMusic() {
    return callAudioPlayerServiceTryAndCatchFunction(
      () => audioPlayer.pause(),
      "Erro ao pausar a musica",
    );
  }

  @override
  Future<void> playMusic(String audioAsset) {
    return callAudioPlayerServiceTryAndCatchFunction(
      () => audioPlayer.play(
        AssetSource(audioAsset),
      ),
      "error ao carregar a musica",
    );
  }

  Future<void> callAudioPlayerServiceTryAndCatchFunction(
    Future<void> Function() tryFunction,
    String audioPlayerExcepitonMessage,
  ) async {
    try {
      await tryFunction();
    } catch (e, s) {
      final errorMessage = audioPlayerExcepitonMessage;
      log(errorMessage, error: e, stackTrace: s);
      throw message.AudioPlayerException(
        message: errorMessage,
      );
    }
  }

  @override
  Future<void> resumeMusic() {
    return callAudioPlayerServiceTryAndCatchFunction(
      () => audioPlayer.resume(),
      "Erro ao continuar musica",
    );
  }

  @override
  Future<void> seek(int seconds) {
    return callAudioPlayerServiceTryAndCatchFunction(
      () {
        final seekTo = Duration(seconds: seconds);
        return audioPlayer.seek(seekTo);
      },
      "Erro ao trocar duração da musica",
    );
  }

  @override
  Future<void> stopMusic() {
    return callAudioPlayerServiceTryAndCatchFunction(
      () => audioPlayer.stop(),
      "erro ao parar a musica",
    );
  }

  @override
  void onClose() {
    audioPlayer
      ..stop()
      ..dispose();
    super.onClose();
  }
}
