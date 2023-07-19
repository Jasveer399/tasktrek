import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasktrek/common/models/task_model.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/features/todo/controllers/todo/todos_provider.dart';
import 'package:tasktrek/features/todo/pages/update_task.dart';
import 'package:tasktrek/features/todo/widgets/todo_tile.dart';

class TodayTask extends ConsumerWidget {
  const TodayTask({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> listdata = ref.watch(todosStateProvider);
    String todayD = ref.read(todosStateProvider.notifier).getTodayD();
    List<Task> todayList = listdata
        .where((element) =>
            element.iscomplested == 0 && element.date!.contains(todayD))
        .toList();
    dynamic rcolor = ref.read(todosStateProvider.notifier).getRendomCl();
    return ListView.builder(
        itemCount: todayList.length,
        itemBuilder: (context, Index) {
          final data = todayList[Index];
          final isCompleted =
              ref.read(todosStateProvider.notifier).getStatus(data);
          return Todotile(
            onTap: () {
              ref.read(todosStateProvider.notifier).deletetodo(data.id ?? 0);
            },
            editwidget: GestureDetector(
                onTap: () {
                  titles=data.title.toString();
                  descs=data.desc.toString();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateTaskpage(id: data.id??0,)));
                },
                child: Icon(
                  MaterialCommunityIcons.circle_edit_outline,
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
                  ref.read(todosStateProvider.notifier).marktaskcomplet(
                      data.id ?? 0,
                      data.title.toString(),
                      data.desc.toString(),
                      1,
                      data.date.toString(),
                      data.startTime.toString(),
                      data.endTime.toString());
                }),
          );
        });
  }
}
