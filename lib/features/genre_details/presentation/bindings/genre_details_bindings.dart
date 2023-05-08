import 'package:get/get.dart';
import 'package:music_app_flutter/features/genre_details/presentation/controllers/genre_details_controller.dart';

class GenreDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GenreDetailsController>(GenreDetailsController());
  }
}
