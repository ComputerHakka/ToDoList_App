import 'package:flutter/material.dart';

import 'task_form_widget_model.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  TaskFormWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskFormWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormModelWidgetProvider(
      model: _model!,
      child: const _TaskFormWidgetBody(),
    );
  }
}

class _TaskFormWidgetBody extends StatelessWidget {
  const _TaskFormWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая задача'),
      ),
      body: Center(
        child: Container(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _TaskNameWidget(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            TaskFormModelWidgetProvider.read(context)?.model.saveTask(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _TaskNameWidget extends StatelessWidget {
  const _TaskNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TaskFormModelWidgetProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      expands: true,
      minLines: null,
      maxLines: null,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Текст задачи',
      ),
      onChanged: (value) => model?.taskText = value,
      onEditingComplete: () => model?.saveTask(context),
    );
  }
}
