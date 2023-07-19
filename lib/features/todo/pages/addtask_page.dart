import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasktrek/common/helper/notification_helper.dart';
import 'package:tasktrek/common/models/task_model.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/appstyle.dart';
import 'package:tasktrek/common/widgets/custom_TextFild.dart';
import 'package:tasktrek/common/widgets/custom_otln_btn.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:tasktrek/common/widgets/showdialog.dart';
import 'package:tasktrek/common/widgets/view_notif.dart';
import 'package:tasktrek/features/todo/controllers/dates/date_provider.dart';
import 'package:tasktrek/features/todo/controllers/todo/todos_provider.dart';
import 'package:tasktrek/features/todo/pages/home_page.dart';

class AddTaskpage extends ConsumerStatefulWidget {
  const AddTaskpage({super.key});

  @override
  ConsumerState<AddTaskpage> createState() => _AddTaskpageState();
}

class _AddTaskpageState extends ConsumerState<AddTaskpage> {
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  late NotificationHelper notifierHelper;
  late NotificationHelper notifiercontroller;
  TextEditingController search = TextEditingController();
  List<int> notificationlist = [];

  @override
  void initState() {
    notifierHelper = NotificationHelper(ref: ref,);
    Future.delayed(Duration(seconds: 0), () {
      notifiercontroller = NotificationHelper(ref: ref);
    });
    notifierHelper.initializationNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var schedualDate = ref.watch(dateStateProvider);
    var starttime = ref.watch(startTimeStateProvider);
    var endtime = ref.watch(endTimeStateProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppConst.KLight),
        title: Text(
          "Add Task",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(children: [
          SizedBox(
            height: 15.0.h,
          ),
          CustomTextFiled(
            style: appstyle(15, AppConst.KBkdark, FontWeight.w500),
            controller: title,
            hintText: "Task Title",
            hintStyle: appstyle(15, AppConst.KBkdark, FontWeight.w500),
          ),
          SizedBox(
            height: 20.0.h,
          ),
          CustomTextFiled(
            style: appstyle(15, AppConst.KBkdark, FontWeight.w500),
            controller: desc,
            hintText: "Add Description",
            hintStyle: appstyle(15, AppConst.KBkdark, FontWeight.w500),
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomOtlnBtn(
              onTap: () {
                picker.DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2018, 3, 5),
                    maxTime: DateTime(2025, 6, 7),
                    theme: picker.DatePickerTheme(
                        itemStyle: TextStyle(
                            color: AppConst.KBkdark,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        doneStyle:
                            TextStyle(color: AppConst.KBkdark, fontSize: 16)),
                    onConfirm: (date) {
                  ref.read(dateStateProvider.notifier).setdate(date.toString());
                }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
              },
              height: 50.h,
              widgth: AppConst.kwidth,
              colorT: AppConst.KLight,
              colorB: AppConst.KGreyLight,
              text: schedualDate == ""
                  ? "Set Date"
                  : schedualDate.substring(0, 10)),
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomOtlnBtn(
                onTap: () {
                  picker.DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    onConfirm: (data) {
                      ref
                          .read(startTimeStateProvider.notifier)
                          .setstartTime(data.toString());
                      notificationlist =
                          ref.read(startTimeStateProvider.notifier).dates(data);
                    },
                    locale: picker.LocaleType.en,
                  );
                },
                height: 50.h,
                widgth: AppConst.kwidth * 0.45,
                colorT: AppConst.KLight,
                colorB: AppConst.KGreyLight,
                text: starttime == ""
                    ? "Start Time"
                    : "S time: ${starttime.substring(10, 16)}",
              ),
              SizedBox(
                width: 10.w,
              ),
              CustomOtlnBtn(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onConfirm: (data) {
                      ref
                          .read(endTimeStateProvider.notifier)
                          .setendTime(data.toString());
                    });
                  },
                  height: 50.h,
                  widgth: AppConst.kwidth * 0.45,
                  colorT: AppConst.KLight,
                  colorB: AppConst.KGreyLight,
                  text: endtime == ""
                      ? "End Time"
                      : " E time: ${endtime.substring(10, 16)}"),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          CustomOtlnBtn(
              onTap: () {
                if (title.text.isNotEmpty &&
                    desc.text.isNotEmpty &&
                    schedualDate.isNotEmpty &&
                    starttime.isNotEmpty &&
                    endtime.isNotEmpty) {
                  Task task = Task(
                    title: title.text,
                    desc: desc.text,
                    date: schedualDate,
                    startTime: starttime.substring(10, 16),
                    endTime: endtime.substring(10, 16),
                    iscomplested: 0,
                    remind: 0,
                    repeat: "",
                  );
                  notifierHelper.schedualedNotification(
                      notificationlist[0],
                      notificationlist[1],
                      notificationlist[2],
                      notificationlist[3],
                      task);
                  ref.read(todosStateProvider.notifier).additems(task);
                  // ref.read(startTimeStateProvider.notifier).setstartTime('');
                  // ref.read(endTimeStateProvider.notifier).setendTime('');
                  // ref.read(dateStateProvider.notifier).setdate('');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Homepage()));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text("Requieard"),
                            content: Text("All Filed are Requierd"),
                            actions: [
                                CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK")),
                            ],
                          ));
                }
              },
              height: 50.h,
              widgth: AppConst.kwidth,
              colorT: AppConst.KLight,
              colorB: Color.fromARGB(255, 34, 42, 65),
              text: "Submit"),
        ]),
      ),
    );
  }
}
