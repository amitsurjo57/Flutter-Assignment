import 'package:flutter/material.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/widgets/Common%20Widget/my_button.dart';
import 'package:greeting_app/widgets/Common%20Widget/snack_bar.dart';
import 'package:greeting_app/widgets/Common%20Widget/user_text_field.dart';
import 'package:greeting_app/widgets/Main%20App/tam_appbar.dart';
import 'package:greeting_app/widgets/Starting%20App/center_progress_indicator.dart';

class CreateNewTaskScreen extends StatefulWidget {
  const CreateNewTaskScreen({super.key});

  @override
  State<CreateNewTaskScreen> createState() => _CreateNewTaskScreenState();
}

class _CreateNewTaskScreenState extends State<CreateNewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Visibility(
                visible: !_inProgress,
                replacement: const CenterProgressIndicator(),
                child: MyButton(
                  onPressed: _onTap,
                ),
              ),
            ],
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
    _inProgress = true;
    setState(() {});
    final Map<String, dynamic> taskBody = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New",
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: NetworkUrls.createTask,
      body: taskBody,
    );

    _inProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _snackBar('New Task Created');
    } else {
      _snackBar(response.errorMessage);
    }
  }

  void _snackBar(String msg) {
    mySnackBar(context, msg);
  }
}
