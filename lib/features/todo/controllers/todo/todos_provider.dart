import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasktrek/common/helper/dp_helper.dart';
import 'package:tasktrek/common/models/task_model.dart';
import 'package:tasktrek/common/utils/constants.dart';
part 'todos_provider.g.dart';

@riverpod
class todosState extends _$todosState {
  @override
  List<Task> build() {
    return [];
  }

  void refresh() async {
    final data = await DBHelper.getItems();
    state = data.map((e) => Task.fromJson(e)).toList();
  }

  void additems(Task task) async {
    await DBHelper.createItem(task);
    refresh();
  }

  void updateItems(
    int id,
    String title,
    String desc,
    int isCompleted,
    String date,
    String startTime,
    String endTime,
  ) async {
    await DBHelper.updateItem(
      id,
      title,
      desc,
      isCompleted,
      date,
      startTime,
      endTime,
    );
    refresh();
  }

  Future<void> deletetodo(int id) async {
    await DBHelper.deleteItem(id);
    refresh();
  }

  void marktaskcomplet(
    int id,
    String title,
    String desc,
    int isCompleted,
    String date,
    String startTime,
    String endTime,
  ) async {
    await DBHelper.updateItem(
      id,
      title,
      desc,
      1,
      date,
      startTime,
      endTime,
    );
    refresh();
  }

  //Get Date From DataBase

  String getTodayD() {
    DateTime todayD = DateTime.now();
    return todayD.toString().substring(0, 10);
  }

  String gettommorroD() {
    DateTime tommorroD = DateTime.now().add(Duration(days: 1));
    return tommorroD.toString().substring(0, 10);
  }

    String getdayafterD() {
    DateTime tommorroD = DateTime.now().add(Duration(days: 2));
    return tommorroD.toString().substring(0, 10);
  } 

  List<String> last30day() {
    DateTime today = DateTime.now();
    DateTime onemonthago = today.subtract(Duration(days: 30));

    List<String> dates = [];
    for (int i = 0; i < 30; i++) {
      DateTime date = onemonthago.add(Duration(days: i));
      dates.add(date.toString().substring(0, 10));
    }
    return dates;
  }

  bool getStatus(Task data) {
    bool? isCompleted;
    if (data.iscomplested == 0) {
      isCompleted = false;
    } else {
      isCompleted = true;
    }
    return isCompleted;
  }

  dynamic getRendomCl(){
    Random random= Random();
    int randomindex=random.nextInt(colors.length);
    return colors[randomindex];
  }
}