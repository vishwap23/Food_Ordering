import 'package:flutter/material.dart';

import 'small_text.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconSize ;
  final Color textColor;
  final Color iconColor;

  const IconTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      this.iconSize =24,
      required this.textColor,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        SizedBox(
          width: 3,
        ),
        SmallText(
          text: text,
          color: textColor,
        )
      ],
    );
  }
}
