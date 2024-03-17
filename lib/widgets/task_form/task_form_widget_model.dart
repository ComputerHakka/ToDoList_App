import 'package:flutter/material.dart';
import 'package:flutter_test_application/domain/entity/group.dart';
import 'package:flutter_test_application/domain/entity/task.dart';
import 'package:hive/hive.dart';

class TaskFormWidgetModel {
  var taskText = '';
  void saveGroup(BuildContext context) async {
    if (taskText.isEmpty) return;
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    final group = Group(name: taskText);
    await box.add(group);
    Navigator.of(context).pop();
  }
}
