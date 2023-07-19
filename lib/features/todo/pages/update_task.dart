import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasktrek/common/models/task_model.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/appstyle.dart';
import 'package:tasktrek/common/widgets/custom_TextFild.dart';
import 'package:tasktrek/common/widgets/custom_otln_btn.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:tasktrek/features/todo/controllers/dates/date_provider.dart';
import 'package:tasktrek/features/todo/controllers/todo/todos_provider.dart';

class UpdateTaskpage extends ConsumerStatefulWidget {
  const UpdateTaskpage({
    super.key,
    required this.id,
  });
  final int id;
  @override
  ConsumerState<UpdateTaskpage> createState() => _UpdateTaskpageState();
}

class _UpdateTaskpageState extends ConsumerState<UpdateTaskpage> {
  final TextEditingController title = TextEditingController(text: titles);
  final TextEditingController desc = TextEditingController(text: descs);
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
          "Update Task",
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
            hintText: "Update Task Title",
            hintStyle: appstyle(15, AppConst.KBkdark, FontWeight.w500),
          ),
          SizedBox(
            height: 20.0.h,
          ),
          CustomTextFiled(
            style: appstyle(15, AppConst.KBkdark, FontWeight.w500),
            controller: desc,
            hintText: "Update Description",
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
                  ref.read(todosStateProvider.notifier).updateItems(
                      widget.id,
                      title.text,
                      desc.text,
                      0,
                      schedualDate,
                      starttime.substring(10,16),
                      endtime.substring(10, 16));
                  ref.read(startTimeStateProvider.notifier).setstartTime('');
                  ref.read(endTimeStateProvider.notifier).setendTime('');
                  ref.read(dateStateProvider.notifier).setdate('');
                  Navigator.pop(context);
                } else {
                  print("All filed need to fill");
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
