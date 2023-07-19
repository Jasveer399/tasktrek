import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/appstyle.dart';
import 'package:tasktrek/common/widgets/reusable_text.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: AppConst.khight,
        width: AppConst.kwidth,
        color: AppConst.KBkdark,
        child: ListView(
         //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Image.asset("assets/images/todo.png",),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                ReusableText(
                    text: "ToDo with TaskTrek",
                    style: appstyle(30.w, AppConst.KLight, FontWeight.w600)),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text("wellcom!! Do you want create a task with TaskTrek",
                  textAlign: TextAlign.center,
                      style: appstyle(14.w, AppConst.KGreyLight, FontWeight.w400)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
