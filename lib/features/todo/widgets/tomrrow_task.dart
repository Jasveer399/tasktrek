import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasktrek/common/models/task_model.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/expansion_tile.dart';
import 'package:tasktrek/features/todo/controllers/todo/todos_provider.dart';
import 'package:tasktrek/features/todo/controllers/xpansion_provider.dart';
import 'package:tasktrek/features/todo/pages/update_task.dart';
import 'package:tasktrek/features/todo/widgets/todo_tile.dart';

class TomorrowTask extends ConsumerWidget {
  const TomorrowTask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoslist = ref.watch(todosStateProvider);
    String tommoroD = ref.read(todosStateProvider.notifier).gettommorroD();
    var rcolors = ref.read(todosStateProvider.notifier).getRendomCl();
    List<Task> tommorrotask = todoslist
        .where(
          (element) => element.date!.contains(tommoroD),
        )
        .toList();

    return XpansionTile(
        tittext: "Tomorrow Task's ",
        subtext: "Tomorrow task's are show there",
        onExpansionChanged: (bool expanded) {
          ref.read(xpansionStateProvider.notifier).setstate(!expanded);
        },
        trailing: Padding(
          padding: EdgeInsets.only(right: 15.0.w, top: 20.h),
          child: ref.watch(xpansionStateProvider)
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
          for (final tommoro in tommorrotask)
            Todotile(
              onTap: () {
                ref
                    .read(todosStateProvider.notifier)
                    .deletetodo(tommoro.id ?? 0);
              },
              editwidget: GestureDetector(
                onTap: () {
                  titles = tommoro.title.toString();
                  descs = tommoro.desc.toString();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UpdateTaskpage(id: tommoro.id ?? 0)));
                },
                child: Icon(
                  MaterialCommunityIcons.circle_edit_outline,
                  color: Colors.white,
                ),
              ),
              tittext: tommoro.title,
              subtext: tommoro.desc,
              starttime: tommoro.startTime,
              color: rcolors,
            ),
        ]);
  }
}
