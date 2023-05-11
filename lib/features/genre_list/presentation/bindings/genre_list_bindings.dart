import 'package:get/get.dart';
import 'package:music_app_flutter/core/services/api_service.dart';
import 'package:music_app_flutter/features/genre_list/presentation/controllers/data/repositories/genre_list_repository.dart';
import 'package:music_app_flutter/features/genre_list/presentation/controllers/genre_list_controller.dart';

class GenreListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GenreListController>(
      GenreListController(
        GenreListRepository(
          apiService: Get.find<ApiService>(),
        ),
      ),
    );
  }
}
