import 'package:flutter/material.dart';
import 'package:greeting_app/ui/controllers/create_new_task_controller.dart';
import 'package:greeting_app/widgets/Common%20Widget/my_button.dart';
import 'package:greeting_app/widgets/Common%20Widget/snack_bar.dart';
import 'package:greeting_app/widgets/Common%20Widget/user_text_field.dart';
import 'package:greeting_app/widgets/Main%20App/tam_appbar.dart';
import 'package:greeting_app/widgets/Common%20Widget/center_progress_indicator.dart';
import 'package:get/get.dart';

class CreateNewTaskScreen extends StatefulWidget {
  const CreateNewTaskScreen({super.key});

  @override
  State<CreateNewTaskScreen> createState() => _CreateNewTaskScreenState();
}

class _CreateNewTaskScreenState extends State<CreateNewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final CreateNewTaskController _createNewTaskController =
      Get.find<CreateNewTaskController>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Navigator.pop(
            context, _createNewTaskController.shouldRefreshPreviousPage);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const TamAppbar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 52,
          ),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Task',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                UserTextField(
                  controller: _titleController,
                  hintText: 'Subject',
                  validateMSG: 'Enter the subject of task',
                ),
                const SizedBox(height: 12),
                UserTextField(
                  controller: _descriptionController,
                  hintText: 'Description',
                  maxLine: 8,
                  validateMSG: 'Enter the description of task',
                ),
                const SizedBox(height: 12),
                GetBuilder(
                  init: CreateNewTaskController(),
                  builder: (createNewTaskController) {
                    return Visibility(
                      visible: !createNewTaskController.inProgress,
                      replacement: const CenterProgressIndicator(),
                      child: MyButton(
                        onPressed: _onTap,
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap() {
    if (_globalKey.currentState!.validate()) {
      _onAddNewTask();
    }
  }

  Future<void> _onAddNewTask() async {
    bool isSuccess = await _createNewTaskController.onAddNewTask(
      title: _titleController.text,
      description: _descriptionController.text,
    );

    if (isSuccess) {
      mySnackBar('New Task Created');
      _clearTextFields();
    } else {
      mySnackBar(_createNewTaskController.errorMessage);
    }
  }

  void _clearTextFields() {
    _titleController.clear();
    _descriptionController.clear();
  }
}
