import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/custom_otln_btn.dart';
import 'package:tasktrek/features/auth/pages/login_page.dart';
import 'package:tasktrek/main.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {

    mq=MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: AppConst.khight,
        width: AppConst.kwidth,
        color: AppConst.KBkdark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Image.asset("assets/images/todo2.png"),
            ),
            SizedBox(
              height: mq.height*0.15,
            ),
            CustomOtlnBtn(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              },
                height: AppConst.khight*0.06,
                widgth: AppConst.kwidth*0.9,
                colorT: AppConst.KLight,
                colorB: AppConst.KBkdark,
                text: "Login with Ph",
                ),
          ],
        ),
      ),
    );
  }
}
