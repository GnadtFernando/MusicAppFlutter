import 'package:flutter/material.dart';
import 'package:music_app_flutter/shared/widgets/image_widget.dart';
import 'package:music_app_flutter/shared/widgets/text_widget.dart';

import '../../../../../../../models/music_model.dart';

class MusicPlayerMusicInfo extends StatelessWidget {
  final MusicModel music;
  const MusicPlayerMusicInfo({
    super.key,
    required this.music,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (_, constrains) {
            return ImageWidget(
              width: constrains.maxWidth,
              height: constrains.maxWidth,
              img: music.img,
            );
          },
        ),
        const SizedBox(height: 14),
        Align(
          alignment: Alignment.topLeft,
          child: TextWidget.title(music.title),
        ),
      ],
    );
  }
}
