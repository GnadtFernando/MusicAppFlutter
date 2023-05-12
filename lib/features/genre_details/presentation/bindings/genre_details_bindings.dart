import 'package:get/get.dart';
import 'package:music_app_flutter/core/services/api_service.dart';
import 'package:music_app_flutter/features/genre_details/data/repositories/genre_details_repository.dart';
import 'package:music_app_flutter/features/genre_details/presentation/controllers/genre_details_controller.dart';
import 'package:music_app_flutter/shared/featues/music_player/presentation/controller/music_player_controller.dart';

class GenreDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GenreDetailsController>(
      GenreDetailsController(
        GenreDetailsRepository(
          apiService: Get.find<ApiService>(),
        ),
        Get.find<MusicPlayerController>(),
      ),
    );
  }
}
