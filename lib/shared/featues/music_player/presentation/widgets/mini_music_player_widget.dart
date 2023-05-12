import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:music_app_flutter/shared/featues/music_player/presentation/widgets/music_player_controls/widgets/play_pause_button_widgets.dart';

import '../../../../../core/app/music_app_colors.dart';
import '../../../../widgets/image_widget.dart';
import '../../../../widgets/text_widget.dart';
import '../controller/music_player_controller.dart';

class MiniMusicPlayerWidget extends StatelessWidget {
  const MiniMusicPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final musicPlayerController = Get.find<MusicPlayerController>();
    return GestureDetector(
      onTap: () => musicPlayerController.showMusicPlayer(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MusicAppColors.primaryColor,
              MusicAppColors.tertiaryColor.withOpacity(0.5),
            ],
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ImageWidget(
                          width: 50,
                          height: 50,
                          img:
                              musicPlayerController.getCurrentPlayingMusic?.img,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextWidget.normal(
                            musicPlayerController
                                    .getCurrentPlayingMusic?.title ??
                                'Música 1',
                          ),
                        ),
                      ],
                    ),
                  ),
                  PlayPauseButtonWidgets(
                    musicUrl: musicPlayerController.getCurrentPlayingMusic?.url,
                    playPauseButtonSize: PlayPauseButtonSize.small,
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: musicPlayerController.getCurrentPositionStream,
              builder: (_, AsyncSnapshot<Duration> snapshot) {
                final currentPositionInSeconds = snapshot.data?.inSeconds ??
                    musicPlayerController.currentMusicDuration.value;

                return LinearProgressIndicator(
                  value: (currentPositionInSeconds /
                          (musicPlayerController
                                  .getCurrentPlayingMusic?.duration ??
                              0))
                      .clamp(0, 1),
                  backgroundColor: Colors.grey.shade600,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    MusicAppColors.secondaryColor,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
