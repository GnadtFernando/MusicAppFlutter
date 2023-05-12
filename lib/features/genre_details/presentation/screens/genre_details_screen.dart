import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_flutter/core/app/music_app_colors.dart';
import 'package:music_app_flutter/shared/featues/music_player/presentation/controller/music_player_controller.dart';
import 'package:music_app_flutter/shared/featues/music_player/presentation/widgets/mini_music_player_widget.dart';
import 'package:music_app_flutter/shared/models/genre_model.dart';

import '../widgets/genre_details_app_bar_widget.dart';
import '../widgets/genre_details_music_list_widget.dart';

class GenreDetailsScreen extends StatelessWidget {
  static const routeName = '/genre-details';
  const GenreDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final musicPlayerController = Get.find<MusicPlayerController>();
    final genre = Get.arguments as GenreModel;

    return Scaffold(
      backgroundColor: MusicAppColors.primaryColor,
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  GenreDetailsAppBarWidget(
                    genre: genre,
                  ),
                  GenreDetailsMusicListWidget(
                    genreSearchString: genre.searchString,
                  ),
                ],
              ),
            ),
            if (musicPlayerController.getPlaylistPlaying.isNotEmpty)
              const MiniMusicPlayerWidget()
          ],
        ),
      ),
    );
  }
}
