import 'package:get/get.dart';
import 'package:music_app_flutter/features/genre_list/presentation/controllers/genre_list_controller.dart';

class GenreListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GenreListController>(GenreListController());
  }
}
