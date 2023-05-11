import 'package:flutter/material.dart';
import 'package:music_app_flutter/core/app/music_app_colors.dart';
import 'package:music_app_flutter/core/app/music_app_text_styles.dart';
import 'package:music_app_flutter/shared/widgets/image_widget.dart';
import 'package:music_app_flutter/shared/widgets/text_widget.dart';

class ImgAndTitleRowWidget extends StatelessWidget {
  final String? heroTag;
  final String? img;
  final String title;
  final Color? titleColor;

  const ImgAndTitleRowWidget({
    this.heroTag,
    this.img,
    required this.title,
    this.titleColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(
          tag: heroTag ?? '',
          child: ImageWidget(
            img: img,
            width: 80,
            height: 80,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextWidget.normal(
            title,
            textStyle: MusicAppTextStyles.getNormalStyle.copyWith(
              color: titleColor ?? MusicAppColors.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
