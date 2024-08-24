import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Text(
          "title will be here",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("description will be hre "),
            Text(
              "12/2/34",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text("new"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 8),
                ),
                OverflowBar(children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.edit)),],)
              ],
            ),
          ],
        ),
      ),
    );
  }
}