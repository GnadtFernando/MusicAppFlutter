import 'package:get/get.dart';
import 'package:music_app_flutter/core/app/music_app_colors.dart';

mixin SnackBarMixin {
  void showErrorSnackbar(String description) {
    Get.snackbar(
      "erro",
      description,
      colorText: MusicAppColors.secondaryColor,
      backgroundColor: MusicAppColors.errorColor,
    );
  }
}
