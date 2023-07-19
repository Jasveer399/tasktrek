import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/appstyle.dart';
import 'package:tasktrek/common/widgets/reusable_text.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConst.KBkdark,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 50.h),
                  child: Image.asset(
                    "assets/images/todo2.png",
                    width: AppConst.kwidth * 0.7,
                  ),
                ),
                ReusableText(
                    text: "Enter you OTP",
                    style: appstyle(18, AppConst.KLight, FontWeight.w500)),
            
                 Padding(
                   padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                   child: Pinput(
                    length: 6,
                    showCursor: true,
                    onChanged: (val){
                      if(val.length==6){}
                    },
                    onSubmitted: (val){
                      if(val.length==6){}
                    },
                   ),
                 ),   
              ],
            ),
          ),
        ),
      ),
    );
  }
}
