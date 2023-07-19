import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/appstyle.dart';
import 'package:tasktrek/common/widgets/reusable_text.dart';
import 'package:tasktrek/main.dart';

class Notification_Page extends StatelessWidget {
  const Notification_Page({super.key, required this.payload});
  final String payload;

  @override
  Widget build(BuildContext context) {
    var title = payload.split('|')[0];
    var contant = payload.split('|')[1];
    var date = payload.split('|')[2].substring(0,10);
    var starttime = payload.split('|')[3];
    var endtime = payload.split('|')[4];
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(icon: Icon(AntDesign.back),onPressed: (){Navigator.pop(context);},),
      ),
      body: SafeArea(
          child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Container(
              width: AppConst.kwidth,
              height: AppConst.khight * 0.7,
              decoration: BoxDecoration(
                color: AppConst.KBklight,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                        text: "Reminder",
                        style: appstyle(40, AppConst.KLight, FontWeight.bold)),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      width: AppConst.kwidth,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppConst.KYellow,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ReusableText(
                              text: "Today",
                              style: appstyle(
                                  14, AppConst.KBkdark, FontWeight.bold)),
                          SizedBox(
                            width: 10.w,
                          ),
                          ReusableText(
                              text: "From : ${starttime} To: ${endtime}",
                              style: appstyle(
                                  14, AppConst.KBkdark, FontWeight.bold)),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            width: 80.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r),
                                bottomRight: Radius.circular(20.r),
                              ),
                              color: AppConst.Kred,
                            ),
                            child: Center(
                              child: Text(date,style:  appstyle(
                                    12, AppConst.KBkdark, FontWeight.bold),
                                    textAlign: TextAlign.center,
                                                      ),
                            ),),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    ReusableText(
                        text: title,
                        style: appstyle(30, AppConst.KBkdark, FontWeight.bold)),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(contant,
                        maxLines: 8,
                        style: appstyle(15, AppConst.KLight, FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              right: 15,
              //top: 5,
              child: Image.asset(
                "assets/images/bell.png",
                width: 45.w,
                height: 40.h,
              )),
          Positioned(
              top: 260.h,
              left: 0,
              right: 0,
              child: Image.asset("assets/images/notification.png",
                  width: mq.width * 0.7, height: mq.height * 0.4))
        ],
      )),
    );
  }
}
