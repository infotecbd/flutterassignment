import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  var taskList = <String>[].obs;

  void addTask(String task) {
    if (task.isNotEmpty) {
      taskList.add(task);
      Get.snackbar('Success', 'Task added!', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.black, colorText: Colors.white);
    } else {
      Get.snackbar('Error', 'Task cannot be empty', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void updateTask(int index, String newTask) {
    if (newTask.isNotEmpty) {
      taskList[index] = newTask;
      Get.snackbar('Updated', 'Task updated!', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.blue, colorText: Colors.white);
    } else {
      Get.snackbar('Error', 'Updated task cannot be empty', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void removeTask(int index) {
    taskList.removeAt(index);
    Get.snackbar('Removed', 'Task removed!', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.black, colorText: Colors.white);
  }
}

class TaskHomePage extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController taskInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskInputController,
                    decoration: InputDecoration(
                      hintText: 'Enter a task',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.lightBlue[50],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    taskController.addTask(taskInputController.text);
                    taskInputController.clear();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: taskController.taskList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    color: Colors.lightBlue[100],
                    child: ListTile(
                      title: Text(
                        taskController.taskList[index],
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue.shade800),
                            onPressed: () => _showEditDialog(context, index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => taskController.removeTask(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    TextEditingController editController = TextEditingController();
    editController.text = taskController.taskList[index];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(
              hintText: 'Update your task',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                taskController.updateTask(index, editController.text);
                Get.back();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
