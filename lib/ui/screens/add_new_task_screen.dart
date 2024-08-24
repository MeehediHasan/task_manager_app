import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/profile_app_bar.dart';

import '../widgets/background_widget.dart';

class AddNewTaskScreen extends StatefulWidget {
  AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add New Task",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: "Title",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        maxLines: 4,
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: "Description",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
