import 'package:flutter/material.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/appstyle.dart';
import 'package:tasktrek/common/widgets/reusable_text.dart';
import 'package:tasktrek/common/widgets/view_notif.dart';

ShowAlertDialog({
  required BuildContext context,
  required String message,
  String? btntext,
  Widget? title,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(
            title:ReusableText(
              text: titles,
              style: appstyle(15, AppConst.KBkdark, FontWeight.w600),
            ), 
            content: ReusableText(
              text: message,
              style: appstyle(15, AppConst.KBkdark, FontWeight.w600),
            ),
          ),
        );
        // ignore: dead_code
        TextButton(
          child: ReusableText(
              text: btntext ?? 'OK',
              style: appstyle(10, AppConst.KLight, FontWeight.w400)),
          onPressed: (){
            Navigator.pop(context);
          },
        );
      });
}
