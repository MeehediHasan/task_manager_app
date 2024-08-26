import 'package:flutter/material.dart';
import 'package:taskmanager/data/task_model_data.dart';

import '../../data/models/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/task_list_wrapper_model.dart';
import '../../data/utilities/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  List<TaskModelData> completedTaskScreenList = [];
  bool _completedTaskApiInProgress = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: profileAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async => _getCompletedTask(),
          child: Visibility(
            visible: _completedTaskApiInProgress == false,
            replacement: Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
              itemCount: completedTaskScreenList.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  taskModelData: completedTaskScreenList[index], onUpdateTask: () {_getCompletedTask();  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getCompletedTask() async {
    _completedTaskApiInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getResponse(
      Urls.completedTask,
    );
    if (mounted) {
      if (response.isSuccess) {
        print(response.statusCode);
        print(response.responseData.toString());
        TaskListWrapper taskListWrapper =
            TaskListWrapper.fromJson(response.responseData);
        completedTaskScreenList = taskListWrapper.taskListData ?? [];

        // showSnackBarMessage(context, "add new task success");
        _completedTaskApiInProgress = false;
        setState(() {});
      } else {
        showSnackBarMessage(context, "add new task failed");
      }
    }
    _completedTaskApiInProgress = false;
    setState(() {});
  }
}
