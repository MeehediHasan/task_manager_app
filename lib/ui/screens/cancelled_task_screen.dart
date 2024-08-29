import 'package:flutter/material.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_count_by_status_wrapper_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/task_list_wrapper_model.dart';
import '../../data/task_model_data.dart';
import '../../data/utilities/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getTaskInProgress = false;
  List<TaskModelData> _taskList = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getTaskInProgress == false,
        replacement: const Center(child: CircularProgressIndicator(),),
        child: ListView.builder(
          itemCount: _taskList.length,
          itemBuilder: (context, index) {
            return TaskItem(
              taskModelData: _taskList[index],
              onUpdateTask: () {
                _getCancelledTasks();
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _getCancelledTasks() async {
    _getTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
    await NetworkCaller.getResponse(Urls.cancelledTask);
    if (response.isSuccess) {
      TaskListWrapper taskListWrapper =
      TaskListWrapper.fromJson(response.responseData);
      _taskList = taskListWrapper.taskListData ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get progress task failed! Try again');
      }
    }
    _getTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
