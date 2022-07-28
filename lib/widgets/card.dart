import 'package:flutter/material.dart';
import 'package:flutter_todo4/screens/task_view.dart';
import 'package:flutter_todo4/screens/home_view.dart';

class MyCard extends StatefulWidget {
  MyCard({
    Key? key,
    required this.text,
    required this.date, //required this.isChecked
    //required this.removeItem
  }) : super(key: key);
  final String text;
  final String date;
  //bool isChecked;
  // final Function(Map<String, String>) removeItem;
  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        margin: const EdgeInsets.all(4),
        color: Colors.grey[800],
        height: 95,
        // width: MediaQuery.of(context).size.width - 50,
        constraints: BoxConstraints(
            //maxHeight: MediaQuery.of(context).size.height / 4,
            maxWidth: MediaQuery.of(context).size.width - 160),
        //padding: const EdgeInsets.all(2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              activeColor: Colors.white,
              checkColor: Colors.black,
              value: //widget.
                  isChecked,
              onChanged: (bool? value) {
                return setState(() {
                  //widget.
                  isChecked = value!;
                });
              },
            ),
            const SizedBox(width: 5),
            Container(
              height: 90,
              constraints: BoxConstraints(
                  //maxHeight: MediaQuery.of(context).size.height / 7,
                  maxWidth: MediaQuery.of(context).size.width - 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white60),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.date,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white54),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
