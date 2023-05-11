import 'package:flutter/material.dart';
import 'package:music_app_flutter/core/app/music_app_text_styles.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const TextWidget(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
  });

  TextWidget.bold(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
  }) : style = textStyle ?? MusicAppTextStyles.getNormalBoldStyle;

  TextWidget.title(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
  }) : style = textStyle ?? MusicAppTextStyles.getTitleStyle;

  TextWidget.normal(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
  }) : style = textStyle ?? MusicAppTextStyles.getNormalStyle;

  TextWidget.small(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
  }) : style = textStyle ?? MusicAppTextStyles.getSmallStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
    );
  }
}
