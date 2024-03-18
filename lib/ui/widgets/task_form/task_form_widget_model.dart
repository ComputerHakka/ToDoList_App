import 'package:flutter/material.dart';
import 'package:flutter_test_application/domain/data_provider/box_manager.dart';
import 'package:flutter_test_application/domain/entity/task.dart';

class TaskFormWidgetModel {
  int groupKey;
  var taskText = '';

  TaskFormWidgetModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    if (taskText.isEmpty) return;

    final task = Task(text: taskText, isDone: false);
    final box = await BoxManager.instance.openTaskBox(groupKey);
    await box.add(task);
    await BoxManager.instance.colseBox(box);
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
