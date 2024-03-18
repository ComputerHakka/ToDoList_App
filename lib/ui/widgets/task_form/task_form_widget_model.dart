import 'package:flutter/material.dart';
import 'package:flutter_test_application/domain/data_provider/box_manager.dart';
import 'package:flutter_test_application/domain/entity/task.dart';

class TaskFormWidgetModel extends ChangeNotifier {
  int groupKey;
  var _taskText = '';

  bool get isValid => _taskText.trim().isNotEmpty;

  set taskText(String value) {
    final isTaskTextEmpty = _taskText.trim().isEmpty;
    _taskText = value;
    if (value.trim().isEmpty != isTaskTextEmpty) {
      notifyListeners();
    }
  }

  TaskFormWidgetModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    final taskText = _taskText.trim();
    if (taskText.isEmpty) return;

    final task = Task(text: taskText, isDone: false);
    final box = await BoxManager.instance.openTaskBox(groupKey);
    await box.add(task);
    await BoxManager.instance.colseBox(box);
    Navigator.of(context).pop();
  }
}

class TaskFormModelWidgetProvider extends InheritedNotifier {
  final TaskFormWidgetModel model;

  const TaskFormModelWidgetProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(
          notifier: model,
        );

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
