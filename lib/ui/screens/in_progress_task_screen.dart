import 'package:flutter/material.dart';
import 'package:taskmanager/data/task_model_data.dart';

import '../../data/models/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/task_list_wrapper_model.dart';
import '../../data/utilities/urls.dart';
import '../widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _progressApiInProgress = false;
  List<TaskModelData> progressTaskScreenList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchGetProgressTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: profileAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: _progressApiInProgress == false,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: progressTaskScreenList.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModelData: progressTaskScreenList[index],
                onUpdateTask: () {
                  _fetchGetProgressTask();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _fetchGetProgressTask() async {
    _progressApiInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getResponse(
      Urls.progressTask,
    );
    _progressApiInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      TaskListWrapper taskListWrapper =
          TaskListWrapper.fromJson(response.responseData);
      progressTaskScreenList = taskListWrapper.taskListData ?? [];
    }
  }
}
