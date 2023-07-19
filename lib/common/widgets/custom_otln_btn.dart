import 'package:flutter/material.dart';
import 'package:tasktrek/common/widgets/appstyle.dart';
import 'package:tasktrek/common/widgets/reusable_text.dart';

class CustomOtlnBtn extends StatelessWidget {
 CustomOtlnBtn(
      {super.key,
      this.onTap,
      required this.height,
      required this.widgth,
      required this.colorT,
      required this.colorB,
      required this.text});

  final void Function()? onTap;
  final double height;
  final double widgth;
  final Color colorT;
  final Color colorB;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: widgth,
        decoration: BoxDecoration(
          color: colorB,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorT, width: 2),
        ),
        child: Center(
            child: ReusableText(
          text: text,
          style: appstyle(18, colorT, FontWeight.w500),
        )),
      ),
    );
  }
}
