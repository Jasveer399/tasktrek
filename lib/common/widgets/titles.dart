import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/appstyle.dart';
import 'package:tasktrek/common/widgets/reusable_text.dart';
import 'package:tasktrek/features/todo/controllers/todo/todos_provider.dart';

class Bottomtitles extends ConsumerWidget {
  const Bottomtitles({super.key, required this.tittext, required this.subtext, this.clr});
   
  final String tittext;
  final String subtext;
  final Color? clr;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var rcolors=ref.read(todosStateProvider.notifier).getRendomCl();
    return SizedBox(
      width: AppConst.kwidth,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(builder: (context, ref, child) {
              return Container(
                height: 80,
                width: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: rcolors,
                ),
              );
            }),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                text: tittext,
                style: appstyle(20, AppConst.KLight, FontWeight.w600)),

               ReusableText(text: subtext, style: appstyle(15, AppConst.KLight, FontWeight.w300)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
