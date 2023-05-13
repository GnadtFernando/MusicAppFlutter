import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_flutter/core/app/music_app_colors.dart';
import 'dart:ui';

import 'package:music_app_flutter/shared/models/music_model.dart';

import 'music_player_controls_widget.dart';
import 'music_player_music_duration.dart';
import 'music_player_music_info.dart';

class MusicPlayerWidget extends StatelessWidget {
  final MusicModel music;
  const MusicPlayerWidget({super.key, required this.music});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 25,
        sigmaY: 25,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: Get.back,
                  icon: const Icon(Icons.arrow_downward_outlined),
                  color: MusicAppColors.secondaryColor,
                ),
                MusicPlayerMusicInfo(music: music),
                const SizedBox(height: 24),
                MusicPlayerMusicDuration(duration: music.duration),
                MusicPlayerControlsWidget(
                  musicPath: music.url,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
