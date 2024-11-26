import 'package:alura/components/task.dart';
import 'package:flutter/material.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<Task> taskList = [
    Task('Diane', 3, 'assets/images/diane.jpg'),
    Task('King', 4, 'assets/images/king.png'),
    Task('Ban', 4, 'assets/images/ban.png'),
    Task('Meliodas', 5, 'assets/images/meliodas.png'),
    Task('Hawk', 1, 'assets/images/hawk.png'),
    Task('Gilthunder', 2, 'assets/images/gilthunder.png'),
    Task('Elizabeth', 2, 'assets/images/elizabeth.png'),
  ];

  void newTask(String name, int difficulty, String photo) {
    taskList.add(Task(name,difficulty, photo));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length != taskList.length;
  }
}
