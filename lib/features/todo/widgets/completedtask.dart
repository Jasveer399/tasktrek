import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasktrek/common/models/task_model.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/features/todo/controllers/todo/todos_provider.dart';
import 'package:tasktrek/features/todo/widgets/todo_tile.dart';

class Completedtask extends ConsumerWidget {
  const Completedtask({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> listdata = ref.watch(todosStateProvider);
    List lastMonth = ref.read(todosStateProvider.notifier).last30day();
    List<Task> completedList = listdata
        .where((element) =>
            element.iscomplested == 1 ||
            lastMonth.contains(element.date!.substring(0,10)))
        .toList();
    dynamic rcolor = ref.read(todosStateProvider.notifier).getRendomCl();
    return ListView.builder(
        itemCount: completedList.length,
        itemBuilder: (context, Index) {
          final data = completedList[Index];
          return Todotile(
              onTap: () {
                ref.read(todosStateProvider.notifier).deletetodo(data.id ?? 0);
              },
              color: rcolor,
              tittext: data.title,
              subtext: data.desc,
              starttime: data.startTime,
              endtime: data.endTime,
              swicther: Icon(
                AntDesign.checkcircle,
                color: AppConst.KGreyBk,size: 30.h,
              ));
        });
  }
}
