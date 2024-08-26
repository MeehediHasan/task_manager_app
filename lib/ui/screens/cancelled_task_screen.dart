import 'package:flutter/material.dart';
import 'package:taskmanager/data/task_list_wrapper_model.dart';
import 'package:taskmanager/data/task_model_data.dart';

import '../../data/models/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../widgets/task_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _canCelledTasApiInProgress = false;
  List<TaskModelData> cancelledTaskScreenList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetchGetCancelledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: profileAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: _canCelledTasApiInProgress == false,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: () async => cancelledTaskScreenList,
            child: ListView.builder(
              itemCount: cancelledTaskScreenList.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  taskModelData: cancelledTaskScreenList[index],
                  onUpdateTask: () {
                    _fetchGetCancelledTask();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchGetCancelledTask() async {
    _canCelledTasApiInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getResponse(
      Urls.cancelledTask,
    );
    _canCelledTasApiInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      TaskListWrapper taskListWrapper =
          TaskListWrapper.fromJson(response.responseData);
      cancelledTaskScreenList = taskListWrapper.taskListData ?? [];
    }
  }
}
