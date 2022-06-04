import 'package:flutter/material.dart';
import 'package:food_ordering/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;

  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = 150;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    print(firstHalf);
    print("Second half");
    print(secondHalf);
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(text: firstHalf)
          : Column(
              children: [
                Text(hiddenText
                    ? (firstHalf + "....")
                    : (firstHalf + secondHalf),style: TextStyle(height: 1.5),),
                // SmallText(
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: hiddenText ? Row(
                    children: [
                      SmallText(
                        text: "Show more",
                        color: Colors.green,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.green,
                      )
                    ],
                  ) :Row(
                    children: [
                      SmallText(
                        text: "Show less",
                        color: Colors.green,
                      ),
                      Icon(
                        Icons.arrow_drop_up,
                        color: Colors.green,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
