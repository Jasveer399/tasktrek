import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasktrek/common/helper/notification_helper.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/appstyle.dart';
import 'package:tasktrek/common/widgets/custom_TextFild.dart';
import 'package:tasktrek/common/widgets/reusable_text.dart';
import 'package:tasktrek/features/todo/controllers/todo/todos_provider.dart';
import 'package:tasktrek/features/todo/pages/addtask_page.dart';
import 'package:tasktrek/features/todo/pages/test.dart';
import 'package:tasktrek/features/todo/widgets/completedtask.dart';
import 'package:tasktrek/features/todo/widgets/dayafterTMtask.dart';
import 'package:tasktrek/features/todo/widgets/todo_task.dart';
import 'package:tasktrek/features/todo/widgets/tomrrow_task.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 2, vsync: this);
  late NotificationHelper notifierHelper;
  late NotificationHelper notifiercontroller;
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    notifierHelper = NotificationHelper(ref: ref);
    Future.delayed(Duration(seconds: 0), () {
      notifiercontroller = NotificationHelper(ref: ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(todosStateProvider.notifier).refresh();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(85.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 29.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: "DasBoard",
                        style: appstyle(18, AppConst.KLight, FontWeight.w500)),
                    Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: AppConst.KLight,
                          borderRadius: BorderRadius.circular(9)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddTaskpage()));
                        },
                        child: Icon(
                          Icons.add,
                          color: AppConst.KBkdark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextFiled(
                controller: search,
                hintText: " Search",
                prefixIcon: Container(
                  padding: EdgeInsets.all(14.h),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      AntDesign.search1,
                      color: AppConst.KGreyDk,
                    ),
                  ),
                ),
                suffixIcon: Icon(
                  FontAwesome.sliders,
                  color: AppConst.KGreyDk,
                ),
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Row(
              children: [
                Icon(
                  FontAwesome.tasks,
                  color: AppConst.KLight,
                ),
                SizedBox(
                  width: 10.w,
                ),
                ReusableText(
                    text: "Today's Task",
                    style: appstyle(18, AppConst.KLight, FontWeight.bold))
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppConst.KLight,
              ),
              child: TabBar(
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppConst.KGreyDk,
                  ),
                  labelPadding: EdgeInsets.zero,
                  labelColor: AppConst.KbluLight,
                  labelStyle: appstyle(16, AppConst.KbluLight, FontWeight.w700),
                  unselectedLabelColor: AppConst.KLight,
                  isScrollable: false,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: AppConst.kwidth * 0.5,
                        child: Center(
                          child: ReusableText(
                            text: "Panding..",
                            style:
                                appstyle(16, AppConst.KGreyBk, FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(left: 30.w),
                        width: AppConst.kwidth * 0.5,
                        child: Center(
                          child: ReusableText(
                            text: "completed",
                            style:
                                appstyle(16, AppConst.KGreyBk, FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              width: AppConst.kwidth,
              height: AppConst.khight * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Container(
                        height: AppConst.khight * 0.3,
                        color: AppConst.KGreyDk,
                        child: TodayTask()),
                    Container(
                      height: AppConst.khight * 0.3,
                      color: AppConst.KGreyDk,
                      child: Completedtask(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            TomorrowTask(),
            SizedBox(
              height: 10.h,
            ),
            DayAfterTM_Task(),
          ],
        ),
      )),
    );
  }
}
