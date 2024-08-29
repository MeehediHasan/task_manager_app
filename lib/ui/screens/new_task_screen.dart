import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/task_count_by_status_wrapper_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/task_list_wrapper_model.dart';
import 'package:taskmanager/data/task_model_data.dart';
import 'package:taskmanager/ui/screens/add_new_task_screen.dart';
import 'package:taskmanager/ui/utility/app_colors.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

import '../../data/models/task_count_by_status_model.dart';
import '../../data/utilities/urls.dart';
import '../widgets/task_item.dart';
import '../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskApiInProgress = false;
  bool _getTaskStatusByCountApiInProgress = true;

  List<TaskModelData> newTaskScreenList = [];
  List<TaskCountByStatusModel> taskCountByStatusList = [];

  @override
  void initState() {
    super.initState();
    _getTaskCountByStatus();
    _getNewTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Column(
          children: [
            buildSummarySection(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _getNewTask();
                  // buildSummarySection();
                  // profileAppBar(context);
                },
                child: Visibility(
                  visible: _getNewTaskApiInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ListView.builder(
                    itemCount: newTaskScreenList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModelData: newTaskScreenList[index],
                        onUpdateTask: () {
                          _getNewTask();
                          _getTaskCountByStatus();
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        onPressed: () {
          _onTapAddButton();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  //fetch newTask from api with get operation
  Future<void> _getNewTask() async {
    _getNewTaskApiInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getResponse(
      Urls.newTask,
    );
    if (mounted) {
      if (response.isSuccess) {
        TaskListWrapper taskListWrapper =
            TaskListWrapper.fromJson(response.responseData);
        newTaskScreenList = taskListWrapper.taskListData ?? [];

        // showSnackBarMessage(context, "add new task success");
        _getNewTaskApiInProgress = false;
        setState(() {});
      } else {
        showSnackBarMessage(context, "add new task failed");
      }
    }
    _getNewTaskApiInProgress = false;
    setState(() {});
  }

// fetch taskStatusCount from api with get operation
  Future<void> _getTaskCountByStatus() async {
    _getTaskStatusByCountApiInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
        await NetworkCaller.getResponse(Urls.taskStatusCount);
    if (response.isSuccess) {
      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel =
          TaskCountByStatusWrapperModel.fromJson(response.responseData);
      taskCountByStatusList =
          taskCountByStatusWrapperModel.taskCountByStatusList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'Get task count by status failed! Try again',
        );
      }
    }
    _getTaskStatusByCountApiInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  void _onTapAddButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
  }

  Widget buildSummarySection() {
    return Visibility(
      visible: _getTaskStatusByCountApiInProgress == false,
      replacement: const CircularProgressIndicator(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: taskCountByStatusList.map((e) {
            return TaskSummaryCard(
              title: (e.sId ?? 'Unknown').toUpperCase(),
              count: e.sum.toString(),
            );
          }).toList(), // Convert the Iterable to List
        ),
      ),
    );
  }
}
