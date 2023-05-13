import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_flutter/core/app/music_app_colors.dart';
import 'package:music_app_flutter/shared/featues/music_player/presentation/controller/music_player_controller.dart';
import 'package:music_app_flutter/shared/featues/music_player/presentation/widgets/widgets/music_player_controls/widgets/play_pause_button_widgets.dart';

class MusicPlayerControlsWidget extends StatelessWidget {
  final String musicPath;
  const MusicPlayerControlsWidget({super.key, required this.musicPath});

  @override
  Widget build(BuildContext context) {
    final musicPlayerController = Get.find<MusicPlayerController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 70,
          onPressed: () => musicPlayerController.backTrack(),
          icon: Icon(
            Icons.skip_previous,
            color: MusicAppColors.secondaryColor,
          ),
          padding: const EdgeInsets.all(0),
        ),
        const SizedBox(width: 40),
        PlayPauseButtonWidgets(musicUrl: musicPath),
        const SizedBox(width: 40),
        IconButton(
          iconSize: 70,
          onPressed: () => musicPlayerController.skipTrack(),
          icon: Icon(
            Icons.skip_next,
            color: MusicAppColors.secondaryColor,
          ),
          padding: const EdgeInsets.all(0),
        ),
      ],
    );
  }
}
