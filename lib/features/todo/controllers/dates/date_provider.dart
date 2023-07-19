import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'date_provider.g.dart';

@riverpod
class DateState extends _$DateState {
  @override
  String build() {
    return "";
  }

  void setdate(String newstate) {
    state = newstate;
  }
}

@riverpod
class StartTimeState extends _$StartTimeState {
  @override
  String build() {
    return "";
  }

  void setstartTime(String newstate) {
    state = newstate;
  }

  List<int> dates(DateTime startdate) {
    DateTime now = DateTime.now();

    Duration difference = startdate.difference(now);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    return [days, hours, minutes, seconds];
  }
}

@riverpod
class EndTimeState extends _$EndTimeState {
  @override
  String build() {
    return "";
  }

  void setendTime(String newstate) {
    state = newstate;
  }
}
