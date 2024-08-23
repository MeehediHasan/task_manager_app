import 'package:flutter/material.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_item.dart';
import '../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: Padding(
        child: Column(
          children: [
            buildSummarySection(),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TaskItem();
                },
              ),
            )
          ],
        ),
        padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
      ),
    );
  }

  Widget buildSummarySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TaskSummaryCard(
            title: 'New task',
            count: "2",
          ),
          TaskSummaryCard(
            title: 'Completed',
            count: "2",
          ),
          TaskSummaryCard(
            title: 'New task',
            count: "2",
          ),
          TaskSummaryCard(
            title: 'New task',
            count: "2",
          ),
        ],
      ),
    );
  }
}

