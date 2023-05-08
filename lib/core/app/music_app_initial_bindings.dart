import 'package:get/get.dart';

import '../../shared/featues/music_player/presentation/controller/music_player_controller.dart';
import '../services/api_service.dart';
import '../services/audio_player_service_impl.dart';

class MusicAppInitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.put(AudioPlayerServiceImpl());
    Get.lazyPut(() => MusicPlayerController());
  }
}
