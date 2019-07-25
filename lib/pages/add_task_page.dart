import 'package:fasyl_attendence_app/core/task_processor.dart';
import 'package:fasyl_attendence_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final _titleFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  var startTime;
  var endTime;
  bool isEndTimeVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add New Task',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
        children: <Widget>[
          TextField(
            focusNode: _titleFocusNode,
            controller: _titleController,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            keyboardType: TextInputType.phone,
            enableInteractiveSelection: true,
            decoration: InputDecoration(
              hasFloatingPlaceholder: true,
              hintText: 'Task Name',
              hintStyle: TextStyle(color: Colors.black),
              contentPadding: EdgeInsets.all(15.0),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              fillColor: Colors.white,
              filled: true,
              labelStyle: TextStyle(color: Colors.black),
              errorStyle: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            focusNode: _descFocusNode,
            controller: _descController,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            minLines: 4,
            maxLines: 10,
            keyboardType: TextInputType.phone,
            enableInteractiveSelection: true,
            decoration: InputDecoration(
              hasFloatingPlaceholder: true,
              hintText: 'Description (optional)',
              hintStyle: TextStyle(color: Colors.black),
              contentPadding: EdgeInsets.all(15.0),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              fillColor: Colors.white,
              filled: true,
              labelStyle: TextStyle(color: Colors.black),
              errorStyle: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: isEndTimeVisible ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  DatePicker.showTimePicker(context, showTitleActions: true,
                      onChanged: (date) {
                  }, onConfirm: (date) {
                    startTime = date;
                    setState(() {
                      isEndTimeVisible = true;
                    });
                  }, currentTime: DateTime.now());
                },
                child: Material(
                  type: MaterialType.button,
                  borderRadius: BorderRadius.circular(45),
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Pick a Start Time',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isEndTimeVisible,
                child: InkWell(
                  onTap: () {
                    DatePicker.showTimePicker(context, showTitleActions: true,
                        onChanged: (date) {
                    }, onConfirm: (date) {
                      setState(() {
                        endTime = date;
                      });
                    }, currentTime: DateTime.now());
                  },
                  child: Material(
                    type: MaterialType.button,
                    borderRadius: BorderRadius.circular(45),
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Pick a End Time',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          type: MaterialType.button,
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width / 2,
            height: 45.0,
            onPressed: () async {
              await validateTaskDetails(_titleController.text,
                  _descController.text, startTime, endTime);
            },
            child: Text(
              'Add Task',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  validateTaskDetails(
      String title, String description, startTime, endTime) async {
    if (title.isNotEmpty && startTime != null && endTime != null ||
        description.isNotEmpty) {
      await saveNewTask(context, title, description, startTime, endTime);
    } else if (title.isEmpty) {
      alertNotification(context, Colors.red, 'Title cannot be Empty.');
    } else if (startTime == null) {
      alertNotification(context, Colors.red, 'Select a Start time');
    } else if (endTime == null) {
      alertNotification(context, Colors.red, 'Select an End time');
    } else {
      alertNotification(context, Colors.red, 'Something went wrong.');
    }
  }
}
