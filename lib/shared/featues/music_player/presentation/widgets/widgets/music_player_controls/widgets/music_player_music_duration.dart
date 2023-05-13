import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_flutter/core/app/music_app_colors.dart';
import 'package:music_app_flutter/core/extensions/duration_extension.dart';
import 'package:music_app_flutter/shared/featues/music_player/presentation/controller/music_player_controller.dart';
import 'package:music_app_flutter/shared/widgets/text_widget.dart';

class MusicPlayerMusicDuration extends StatefulWidget {
  final int duration;
  const MusicPlayerMusicDuration({super.key, required this.duration});

  @override
  State<MusicPlayerMusicDuration> createState() =>
      _MusicPlayerMusicDurationState();
}

class _MusicPlayerMusicDurationState extends State<MusicPlayerMusicDuration> {
  final sliderValueRx = RxnDouble();
  @override
  Widget build(BuildContext context) {
    final musicPlyerController = Get.find<MusicPlayerController>();
    return StreamBuilder(
      stream: musicPlyerController.getCurrentPositionStream,
      builder: (context, AsyncSnapshot<Duration> snapshot) {
        final seconds = snapshot.data?.inSeconds ??
            musicPlyerController.currentMusicDuration.value;
        return Column(
          children: [
            Obx(
              () => Slider(
                value: (sliderValueRx.value ?? seconds / widget.duration)
                    .clamp(0, 1),
                onChanged: (double sliderValue) async {
                  await musicPlyerController.seek(
                    (sliderValue * widget.duration).floor(),
                  );
                  sliderValueRx.value = null;
                },
                activeColor: MusicAppColors.secondaryColor,
                inactiveColor: Colors.grey.shade700,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget.small(
                  seconds.fromSecondsToMinutesString,
                ),
                TextWidget.small(
                  '- ${(widget.duration - seconds).fromSecondsToMinutesString}',
                )
              ],
            )
          ],
        );
      },
    );
  }
}
