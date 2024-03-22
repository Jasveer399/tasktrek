import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasktrek/common/helper/notification_helper.dart';
import 'package:tasktrek/common/models/task_model.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/appstyle.dart';
import 'package:tasktrek/common/widgets/custom_TextFild.dart';
import 'package:tasktrek/common/widgets/reusable_text.dart';
import 'package:tasktrek/features/todo/controllers/todo/todos_provider.dart';
import 'package:tasktrek/features/todo/pages/addtask_page.dart';
import 'package:tasktrek/features/todo/pages/update_task.dart';
import 'package:tasktrek/features/todo/widgets/completedtask.dart';
import 'package:tasktrek/features/todo/widgets/dayafterTMtask.dart';
import 'package:tasktrek/features/todo/widgets/todo_task.dart';
import 'package:tasktrek/features/todo/widgets/todo_tile.dart';
import 'package:tasktrek/features/todo/widgets/tomrrow_task.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({Key? key}) : super(key: key);

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
  List<Task> filtertask = [];

  @override
  void initState() {
    notifierHelper = NotificationHelper(ref: ref);
    Future.delayed(Duration(seconds: 0), () {
      notifiercontroller = NotificationHelper(ref: ref);
    });
    super.initState();
  }

  void filterTasks(String query) {
    if (query.isEmpty) {
      setState(() {
        filtertask.clear();
      });
      return;
    }
    final List<Task> filteredTasks = ref
        .read(todosStateProvider)
        .where((task) =>
            task.title!.toLowerCase().contains(query.toLowerCase()) ||
            task.desc!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filtertask = filteredTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(todosStateProvider.notifier).refresh();
    dynamic rcolor = ref.read(todosStateProvider.notifier).getRendomCl();
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
                      text: "DashBoard",
                      style: appstyle(18, AppConst.KLight, FontWeight.w500),
                    ),
                    Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: AppConst.KLight,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTaskpage(),
                            ),
                          );
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
              SizedBox(height: 15.h),
              CustomTextFiled(
                controller: search,
                hintText: " Search",
                onChanged: (query) {
                  filterTasks(query);
                },
                prefixIcon: Container(
                  padding: EdgeInsets.all(14.h),
                  child: Icon(
                    AntDesign.search1,
                    color: AppConst.KGreyDk,
                  ),
                ),
                suffixIcon: Icon(
                  FontAwesome.sliders,
                  color: AppConst.KGreyDk,
                ),
              ),
              SizedBox(height: 10.h)
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              SizedBox(height: 40.h),
              Row(
                children: [
                  Icon(
                    FontAwesome.tasks,
                    color: AppConst.KLight,
                  ),
                  SizedBox(width: 10.w),
                  ReusableText(
                    text: "Today's Task",
                    style: appstyle(18, AppConst.KLight, FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
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
                            text: "Pending..",
                            style: appstyle(
                              16,
                              AppConst.KGreyBk,
                              FontWeight.bold,
                            ),
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
                            style: appstyle(
                              16,
                              AppConst.KGreyBk,
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
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
                        child: filtertask.isEmpty
                            ? TodayTask()
                            : ListView.builder(
                                itemCount: filtertask.length,
                                itemBuilder: (context, index) {
                                  final data = filtertask[index];
                                  final isCompleted = ref
                                      .read(todosStateProvider.notifier)
                                      .getStatus(data);
                                  return Todotile(
                                    onTap: () {
                                      ref
                                          .read(todosStateProvider.notifier)
                                          .deletetodo(data.id ?? 0);
                                    },
                                    editwidget: GestureDetector(
                                        onTap: () {
                                          titles = data.title.toString();
                                          descs = data.desc.toString();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateTaskpage(
                                                        id: data.id ?? 0,
                                                      )));
                                        },
                                        child: Icon(
                                          MaterialCommunityIcons
                                              .circle_edit_outline,
                                          color: Colors.white,
                                        )),
                                    color: rcolor,
                                    tittext: data.title,
                                    subtext: data.desc,
                                    starttime: data.startTime,
                                    endtime: data.endTime,
                                    swicther: Switch(
                                        value: isCompleted,
                                        onChanged: (val) {
                                          ref
                                              .read(todosStateProvider.notifier)
                                              .marktaskcomplet(
                                                  data.id ?? 0,
                                                  data.title.toString(),
                                                  data.desc.toString(),
                                                  1,
                                                  data.date.toString(),
                                                  data.startTime.toString(),
                                                  data.endTime.toString());
                                        }),
                                  );
                                },
                              ),
                      ),
                      Container(
                        height: AppConst.khight * 0.3,
                        color: AppConst.KGreyDk,
                        child: Completedtask(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              TomorrowTask(),
              SizedBox(height: 10.h),
              DayAfterTM_Task(),
            ],
          ),
        ),
      ),
    );
  }
}
