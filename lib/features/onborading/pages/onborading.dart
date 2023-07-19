import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/appstyle.dart';
import 'package:tasktrek/common/widgets/reusable_text.dart';
import 'package:tasktrek/features/onborading/widgets/page_one.dart';
import 'package:tasktrek/features/onborading/widgets/page_two.dart';

class OnBorading_Page extends StatefulWidget {
  const OnBorading_Page({super.key});

  @override
  State<OnBorading_Page> createState() => _OnBorading_PageState();
}

class _OnBorading_PageState extends State<OnBorading_Page> {
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: AlwaysScrollableScrollPhysics(),
            controller: pageController,
            children: [
              PageOne(),
              //SizedBox(width: 10,),
              PageTwo(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                        pageController.nextPage(
                              duration: Duration(milliseconds: 600),
                              curve: Curves.ease);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Ionicons.chevron_forward_circle,
                          color: AppConst.KLight,
                          size: 25,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        ReusableText(
                            text: "Skip",
                            style: appstyle(17, AppConst.KLight, FontWeight.w500)),
                        
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 2,
                      effect: WormEffect(
                          dotHeight: 12,
                          dotWidth: 18,
                          dotColor: AppConst.KLight,
                          activeDotColor: AppConst.KYellow,
                          spacing: 10,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
