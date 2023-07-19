import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/titles.dart';

class XpansionTile extends StatelessWidget {
  XpansionTile(
      {super.key,
      required this.tittext,
      required this.subtext,
      this.clr,
      this.onExpansionChanged,
      this.trailing,
      required this.children});

  final String tittext;
  final String subtext;
  final Color? clr;
  final void Function(bool)? onExpansionChanged;
  final Widget? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConst.KGreyDk,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: Bottomtitles(
            tittext: tittext,
            subtext: subtext,
          ),
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          onExpansionChanged: onExpansionChanged,
          trailing: trailing,
          children: children,
        ),
      ),
    );
  }
}
