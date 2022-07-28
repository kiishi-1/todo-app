import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo4/constants/load_images.dart';
import 'package:flutter_todo4/main.dart';
import 'package:flutter_todo4/screens/task_view.dart';
import 'package:flutter_todo4/widgets/card.dart';
import 'package:flutter_todo4/widgets/text_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_todo4/constants/storage_keys.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late List<Map<String, dynamic>> items = [];
  late final SharedPreferences sharedPreferences;
  final LoadImage loadImage = LoadImage();
  bool loading = false;

  addItem(Map<String, dynamic> item) {
    setState(() {
      items.add(item);
      saveListLocally();
      print(jsonEncode(items));
    });
  }
  //(Map<String, String> item) since we are creating the items of Map in the index or position

  removeItem(int index) {
    setState(() {
      items.removeAt(index);
      saveListLocally();
    });
  }
  //(int index) since we are removing the index or position to delete the item

  openDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('About the App'),
        content: TextContainer(),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Done',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black),
              ))
        ],
      ),
    );
  }

  @override
  initState() {
    init();
    super.initState();
    print(jsonEncode(items));
  }

  Future<void> init() async {
    setState(() {
      loading = true;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    getLocalList();
    setState(() {
      loading = false;
    });
  }

  Future<void> saveListLocally() async {
    await sharedPreferences.setString(
      StorageKey.task,
      jsonEncode(items),
    );
    print('done');
  }

  Future<void> getLocalList() async {
    setState(() {
      print('getting');
      items = jsonDecode(
        sharedPreferences.getString(StorageKey.task) ??
            <Map<String, dynamic>>[].toString(),
        //using toString for [].toString cus sharedPreference will set to String. you can also use '[]'
        //if there is no data saved locally, it'll show an empty list []
      ).map<Map<String, dynamic>>((e) => e as Map<String, dynamic>).toList();
      print('gotten');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[800],
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskView(
                          onSave: addItem,
                          //tasktitle and datetitle is 'required' that is why it is here but it is not needed here
                          //it doesn't have to be here but cus it is 'required' we put it here
                          //hence, why it is an empty string
                          tasktitle: '',
                          datetitle: '',
                        )));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/3.jpg'), fit: BoxFit.cover),
                ),
                child: ListView(
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
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              openDialog();
                            },
                            child: const Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...List.generate(items.length, (index) {
                      return Row(children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TaskView(
                                            onSave: (updatedTask) {
                                              setState(() {
                                                items[index] = updatedTask;
                                              });
                                            }, //onsave is returning a map and we want to assign the map to items[index]
                                            tasktitle: items[index]['text1']!,
                                            datetitle: items[index]['text2']!,
                                          )));
                            },
                            //we don't have to use onSave here when returning TaskView cus we made onSave nullable
                            child: MyCard(
                              text: items[index]['text1']!,
                              date: items[index]['text2']!,
                              //isChecked: items[index]['ticked'],
                              //removeItem:,
                              // we added ! cus the onSave function is nullable and you're trying to access the list in the nullable function
                              //items is a List of Map hence items[][].The Map {'text1': controller1.text, 'text2': controller2.text}
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              removeItem(index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ))
                      ]);
                    }),
                  ],
                ),
              ),
      ),
    );
  }
}
