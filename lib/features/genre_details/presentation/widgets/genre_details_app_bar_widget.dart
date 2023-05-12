import 'package:flutter/material.dart';
import 'package:music_app_flutter/core/extensions/media_query_extension.dart';
import 'package:music_app_flutter/shared/models/genre_model.dart';
import 'package:music_app_flutter/shared/widgets/image_widget.dart';
import 'package:music_app_flutter/shared/widgets/text_widget.dart';

class GenreDetailsAppBarWidget extends StatelessWidget {
  final GenreModel genre;
  const GenreDetailsAppBarWidget({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: context.getWidth / 1.5,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.only(bottom: context.getWidth / 3 - 12),
        title: TextWidget.title(genre.title),
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
        ],
        background: Hero(
          tag: genre.title,
          child: ImageWidget(
            width: context.getWidth,
            height: context.getWidth / 1.5,
            img: genre.img,
          ),
        ),
      ),
    );
  }
}
