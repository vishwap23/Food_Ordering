import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;
  final double height;

  const SmallText(
      {Key? key,
      this.height = 1.2,
      required this.text,
      this.color = Colors.black54,
      this.size = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style:
          TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w400,height: height),
    );
  }
}
