import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/appstyle.dart';
import 'package:tasktrek/common/widgets/reusable_text.dart';

class Todotile extends StatelessWidget {
  Todotile(
      {super.key,
      this.tittext,
      this.subtext,
      this.starttime,
      this.endtime,
      this.color,
      this.editwidget,
      this.swicther,
      this.onTap});

  final String? tittext;
  final String? subtext;
  final String? starttime;
  final String? endtime;
  final Color? color;
  final Widget? editwidget;
  final Widget? swicther;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            width: AppConst.kwidth,
            height: 130.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              color: AppConst.KGreyLight,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: color ?? AppConst.Kred,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0.h),
                      child: SizedBox(
                        width: AppConst.kwidth * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: tittext.toString(),
                                style: appstyle(
                                    20, AppConst.KLight, FontWeight.w600)),
                            ReusableText(
                                text: subtext.toString(),
                                style: appstyle(
                                    15, AppConst.KLight, FontWeight.w300)),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 25.h,
                                  width: AppConst.kwidth * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: AppConst.KBkdark,
                                  ),
                                  child: Center(
                                      child: ReusableText(
                                          text: "$starttime | $endtime",
                                          style: appstyle(15, AppConst.KLight,
                                              FontWeight.w500))),
                                ),
                                SizedBox(
                                  width: 30.w,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: editwidget,
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    GestureDetector(
                                      onTap: onTap,
                                      child: Icon(
                                        MaterialCommunityIcons.delete_circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  child: swicther,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
