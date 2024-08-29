import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/task_model_data.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

import '../../data/utilities/urls.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.taskModelData,
    required this.onUpdateTask,
  });

  final TaskModelData taskModelData;
  final VoidCallback onUpdateTask;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _deleteInProgress = false;
  bool _editInProgress = false;
  String dropDownValue = "";
  List<String> statusList = ['New Task', 'completed', 'in Progress', 'cancelled'];

  @override
  void initState() {
    super.initState();
    dropDownValue = widget.taskModelData.status!;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Text(
          widget.taskModelData.title ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModelData.description ?? ''),
            Text(
              widget.taskModelData.createdDate ?? '',
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(widget.taskModelData.status ?? "New"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                Visibility(
                  visible: _deleteInProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: OverflowBar(
                    children: [
                      IconButton(
                        onPressed: () {
                          _deleteTask();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      Visibility(
                        visible: _editInProgress == false,
                        replacement: Center(
                          heightFactor: 10,
                          child: CircularProgressIndicator(),
                        ),
                        child: PopupMenuButton<String>(
                          // color: Colors.red,

                          icon: const Icon(Icons.edit),
                          onSelected: (String selectedValue) {
                            dropDownValue = selectedValue;
                            _updateTask(dropDownValue);

                            if (mounted) {
                              setState(() {});
                            }
                          },
                          itemBuilder: (context) {
                            return statusList.map((String currentValue) {
                              return PopupMenuItem<String>(
                                value: currentValue,
                                child: ListTile(
                                  // tileColor: Colors.red,
                                  title: Text(currentValue),
                                  trailing: dropDownValue == currentValue
                                      ? Icon(
                                          Icons.done,
                                          color: Colors.green,
                                        )
                                      : null,
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

//-------delete task---------
  Future<void> _deleteTask() async {
    _deleteInProgress = false;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getResponse(
      Urls.deleteTask(widget.taskModelData.sId!),
    );
    if (response.isSuccess) {
      widget.onUpdateTask();
      showSnackBarMessage(context, 'Delete task success!', false);
    } else {
      showSnackBarMessage(context, 'Delete task failed!', true);
    }

    _deleteInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
 //-----------updateTask
  Future<void> _updateTask(String status) async {
    _editInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getResponse(
        Urls.updateTaskStatus(widget.taskModelData.sId!, status));

    if (response.isSuccess) {
      widget.onUpdateTask();
    } else {
      if (mounted) {
        _editInProgress = false;
        setState(() {});
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'Update task status failed! Try again',
        );
      }
    }
  }
}
