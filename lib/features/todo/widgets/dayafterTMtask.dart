import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/expansion_tile.dart';
import 'package:tasktrek/features/todo/controllers/todo/todos_provider.dart';
import 'package:tasktrek/features/todo/controllers/xpansion_provider.dart';
import 'package:tasktrek/features/todo/pages/update_task.dart';
import 'package:tasktrek/features/todo/widgets/todo_tile.dart';

class DayAfterTM_Task extends ConsumerWidget {
  const DayAfterTM_Task({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todolist = ref.watch(todosStateProvider);
    var dayafterTmD = ref.read(todosStateProvider.notifier).getdayafterD();

    var dayafterTMtask = todolist
        .where(
          (element) => element.date!.contains(dayafterTmD),
        )
        .toList();
    var rcolors = ref.read(todosStateProvider.notifier).getRendomCl();
    return XpansionTile(
        tittext:
            DateTime.now().add(Duration(days: 2)).toString().substring(5, 10),
        subtext: "Day After Tomorrow task's",
        onExpansionChanged: (bool expanded) {
          ref.read(xpansionState0Provider.notifier).setstate(!expanded);
        },
        trailing: Padding(
          padding: EdgeInsets.only(right: 15.0.w, top: 20.h),
          child: ref.watch(xpansionState0Provider)
              ? Icon(
                  AntDesign.circledown,
                  color: AppConst.KGreen,
                )
              : Icon(
                  AntDesign.closecircle,
                  color: AppConst.Kred,
                ),
        ),
        children: [
          for (final dayATm in dayafterTMtask)
            Todotile(
              onTap: () {
                ref
                    .read(todosStateProvider.notifier)
                    .deletetodo(dayATm.id ?? 0);
              },
              editwidget: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UpdateTaskpage(id: dayATm.id ?? 0)));
                },
                child: Icon(MaterialCommunityIcons.circle_edit_outline),
              ),
              color: rcolors,
              tittext: dayATm.title,
              subtext: dayATm.desc,
              starttime: dayATm.startTime,
              endtime: dayATm.endTime,
            ),
        ]);
  }
}
