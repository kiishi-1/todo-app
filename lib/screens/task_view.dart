import 'package:flutter/material.dart';
import 'package:flutter_todo4/screens/home_view.dart';
import 'package:intl/intl.dart';

class TaskView extends StatefulWidget {
  final Function(Map<String, dynamic>)? onSave;
  //Map<String, String> since we are send two data at once that is, controller1 and controller2
  //this will be written as onSave({'text1':controller1.text, 'text2':controller2.text}); note: {} indicates the use of Map
  //? is to make it nullable meaning onsave is not required literally and figueratively i.e you don't always have to call it or use it
  TaskView(
      {Key? key, this.onSave, required this.tasktitle, required this.datetitle})
      : super(key: key);
  String tasktitle;
  String datetitle;
  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();

  Future<Null> selectDate(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000));

    if (datePicker != null && datePicker != date) {
      setState(() {
        date = datePicker;
      });
    }
  }

  @override
  void initState() {
    controller1.text = widget.tasktitle;
    controller2.text = widget.datetitle;
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[800],
          onPressed: () {
            widget.onSave!(
                {'text1': controller1.text, 'text2': controller2.text, //'ticked':false
                });
            // ! is a null check makes it so that it doesn't return null
            // we put ! here cus onsave is nullable i.e final Function(Map<String, String>)? onSave; hence, ! make sure it doesn't return null
            Navigator.pop(context);
          },
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
        body: Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  image: AssetImage('assets/3.jpg'), fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  height: 75,
                  width: double.infinity,
                  color: Colors.grey[800],
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        width: 85,
                      ),
                      Text(
                        'Input Task',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: controller1,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'value is empty';
                          } else {
                            return null;
                          }
                        },
                        maxLines: 2,
                        style: const  TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            hintText: 'Enter Task',
                            hintMaxLines: 2,
                            hintStyle:
                                TextStyle(fontSize: 20, color: Colors.white70),
                            /*border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 3,
                                  )
                                ),*/
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white54,
                                width: 3,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ))),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      TextFormField(
                        controller: controller2,
                        onTap: () async {
                          await selectDate(context);
                          setState(() {
                            controller2.text = DateFormat.yMMMd().format(date);
                          });
                        },
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            hintText: 'Enter Date',
                            hintMaxLines: 1,
                            hintStyle:
                                TextStyle(fontSize: 20, color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white54,
                                width: 3,
                                style: BorderStyle.solid,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
