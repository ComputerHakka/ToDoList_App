import 'package:flutter/material.dart';
import 'package:flutter_test_application/domain/entity/group.dart';
import 'package:flutter_test_application/domain/entity/task.dart';
import 'package:hive/hive.dart';

class TaskFormWidgetModel {
  int groupKey;
  var taskText = '';

  TaskFormWidgetModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    if (taskText.isEmpty) return;
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final taskBox = await Hive.openBox<Task>('tasks_box');
    final task = Task(text: taskText, isDone: false);
    await taskBox.add(task);

    final groupBox = await Hive.openBox<Group>('groups_box');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);
    Navigator.of(context).pop();
  }
}

class TaskFormModelWidgetProvider extends InheritedWidget {
  final TaskFormWidgetModel model;

  const TaskFormModelWidgetProvider({
    super.key,
    required this.model,
    required super.child,
  });

  static TaskFormModelWidgetProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskFormModelWidgetProvider>();
  }

  static TaskFormModelWidgetProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormModelWidgetProvider>()
        ?.widget;
    return widget is TaskFormModelWidgetProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TaskFormModelWidgetProvider oldWidget) {
    return false;
  }
}
