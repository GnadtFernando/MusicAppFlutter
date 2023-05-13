import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_flutter/core/extensions/media_query_extension.dart';
import 'package:music_app_flutter/core/mixins/snack_bar_mixin.dart';
import 'package:music_app_flutter/core/services/audio_player_service.dart';
import 'package:music_app_flutter/shared/featues/music_player/presentation/widgets/music_player_controls/widgets/music_player_widget.dart';
import 'package:music_app_flutter/shared/models/music_model.dart';
import 'package:music_app_flutter/core/errors/exceptions.dart' as message;

class MusicPlayerController with SnackBarMixin {
  final AudioPlayerService _audioPlayer;

  MusicPlayerController(AudioPlayerService audioPlayer)
      : _audioPlayer = audioPlayer {
    _audioCompleteStreamSubscription =
        _audioPlayer.onAudioComplete().listen((_) {
      skipTrack();
    });
  }

  StreamSubscription? _audioCompleteStreamSubscription;
  final RxBool isPlaying = false.obs;
  final RxInt currentMusicDuration = 0.obs;
  final RxnInt currentMusicIndexPlaying = RxnInt();
  int? get getCurrentMusicIndexPlaying => currentMusicIndexPlaying.value;
  final RxList<MusicModel> _playlistPlaying = <MusicModel>[].obs;
  List<MusicModel> get getPlaylistPlaying => _playlistPlaying;
  final List<MusicModel> selectedPlaylist = [];
  Stream<Duration> get getCurrentPositionStream =>
      _audioPlayer.getPositionStream();
  Future<void> seek(int seekToDurationInSeconds) =>
      _audioPlayer.seek(seekToDurationInSeconds);

  void loadPlaylist(
      List<MusicModel> newPlaylist, List<MusicModel> playListToChange) {
    playListToChange
      ..clear()
      ..addAll(newPlaylist);
  }

  Future<void> onCallMusicPlayerTryAndCatchFunction(
      Future<void> Function() tryFunction) async {
    try {
      await tryFunction();
    } on message.AudioPlayerException catch (error) {
      showErrorSnackbar(error.message);
    }
  }

  Future<void> playMusic(String url) async {
    return onCallMusicPlayerTryAndCatchFunction(() async {
      isPlaying.value = true;
      await _audioPlayer.playMusic(url);
    });
  }

  Future<void> stopMusic() async {
    return onCallMusicPlayerTryAndCatchFunction(() async {
      isPlaying.value = false;
      await _audioPlayer.stopMusic();
    });
  }

  Future<void> loadMusic() async {
    return onCallMusicPlayerTryAndCatchFunction(() async {
      loadPlaylist(selectedPlaylist, _playlistPlaying);
      await stopMusic();
      await playMusic(
        _playlistPlaying[getCurrentMusicIndexPlaying ?? 0].url,
      );
    });
  }

  Future<void> pauseMusic() async {
    return onCallMusicPlayerTryAndCatchFunction(() async {
      isPlaying.value = false;
      await _audioPlayer.pauseMusic();
    });
  }

  Future<void> skipTrack() async {
    if (getCurrentMusicIndexPlaying != null) {
      if (getCurrentMusicIndexPlaying! < _playlistPlaying.length - 1) {
        currentMusicIndexPlaying.value = currentMusicIndexPlaying.value! + 1;
      } else {
        currentMusicIndexPlaying.value = 0;
      }
      await loadMusic();
    }
  }

  MusicModel? get getCurrentPlayingMusic {
    if (getCurrentMusicIndexPlaying != null) {
      return _playlistPlaying[getCurrentMusicIndexPlaying!];
    }
    return null;
  }

  Future<void> backTrack() async {
    if (getCurrentMusicIndexPlaying != null &&
        getCurrentMusicIndexPlaying! > 0) {
      currentMusicIndexPlaying.value = currentMusicIndexPlaying.value! - 1;
    } else {
      currentMusicIndexPlaying.value = _playlistPlaying.length - 1;
    }
    await loadMusic();
  }

  void dispose() {
    _audioCompleteStreamSubscription?.cancel();
  }

  Future<void> loadCurrentMusicDuration() async {
    if (!isPlaying.value) {
      currentMusicDuration.value = await _audioPlayer.getCurrentPosition;
    }
  }

  void playSelectedMusic(BuildContext context, int musicIndex) {
    currentMusicIndexPlaying.value = musicIndex;

    loadMusic();

    showMusicPlayer(context);
  }

  Future<void> showMusicPlayer(BuildContext context) async {
    loadCurrentMusicDuration();

    showBottomSheet(
      context: context,
      builder: (_) => Obx(
        () => MusicPlayerWidget(
            music: _playlistPlaying[getCurrentMusicIndexPlaying ?? 0]),
      ),
      constraints: BoxConstraints(
        maxHeight: context.getHeight - context.getTopPadding,
      ),
      backgroundColor: Colors.transparent,
      enableDrag: true,
    );
  }
}
