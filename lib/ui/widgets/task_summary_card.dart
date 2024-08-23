import 'package:flutter/material.dart';

class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({
    super.key,
    required this.title,
    required this.count,
  });
  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,

      child: Padding(
        padding: const EdgeInsets.all(16.0), // Increased padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          children: [
            Text(
              count,
              style: Theme.of(context).textTheme.titleLarge, // Increased text size
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall, // Increased text size
            ),
          ],
        ),
      ),
    );
  }
}