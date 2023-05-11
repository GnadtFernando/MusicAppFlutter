import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:music_app_flutter/core/services/dot_env_service.dart';

import '../../shared/featues/music_player/presentation/controller/music_player_controller.dart';
import '../services/api_service.dart';
import '../services/audio_player_service_impl.dart';

class MusicAppInitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService(
      BaseOptions(
        baseUrl: DotEnvService.getApiBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ));
    Get.put(AudioPlayerServiceImpl(AudioPlayer()));
    Get.lazyPut(() => MusicPlayerController());
  }
}
