import 'package:flutter/material.dart';
import 'package:steam/core/constants/colors.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLength;

  const ExpandableText({super.key, required this.text, this.trimLength = 200});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final displayText = isExpanded || widget.text.length <= widget.trimLength
        ? widget.text
        : '${widget.text.substring(0, widget.trimLength)}...';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayText,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.myGrey2,
            fontWeight: FontWeight.w300,
          ),
        ),
        if (widget.text.length > widget.trimLength)
          TextButton(
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              isExpanded ? 'مشاهده کمتر' : 'مشاهده بیشتر',
              style: const TextStyle(color: AppColors.blue),
            ),
          ),
      ],
    );
  }
}
