import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_flutter/features/genre_details/presentation/screens/genre_details_screen.dart';
import 'package:music_app_flutter/features/genre_list/presentation/controllers/genre_list_controller.dart';
import 'package:music_app_flutter/shared/featues/music_player/presentation/controller/music_player_controller.dart';
import 'package:music_app_flutter/shared/featues/music_player/presentation/widgets/mini_music_player_widget.dart';
import 'package:music_app_flutter/shared/widgets/screen_widget.dart';

import '../../../../shared/widgets/img_and_title_row_widget.dart';

class GenreListScreen extends StatelessWidget {
  static const routeName = '/genre-list';
  const GenreListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final genreListContrl = Get.find<GenreListController>();
    final musicPlayerController = Get.find<MusicPlayerController>();
    return Obx(
      () => ScreenWidget(
        isLoading: genreListContrl.getIsLoading,
        title: 'Lista de Gêneros',
        error: genreListContrl.getError,
        onTryAgain: () => genreListContrl.getGenreList(),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  itemBuilder: (_, int index) {
                    final genre = genreListContrl.genres[index];
                    return InkWell(
                      onTap: () => Get.toNamed(
                        '${GenreListScreen.routeName}${GenreDetailsScreen.routeName}',
                        arguments: genre,
                      ),
                      child: ImgAndTitleRowWidget(
                        title: genre.title,
                        heroTag: genre.title,
                        img: genre.img,
                      ),
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const SizedBox(height: 12);
                  },
                  itemCount: genreListContrl.genres.length,
                ),
              ),
            ),
            if (musicPlayerController.getPlaylistPlaying.isNotEmpty)
              const MiniMusicPlayerWidget(),
          ],
        ),
      ),
    );
  }
}
