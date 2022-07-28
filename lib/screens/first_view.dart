import 'package:flutter/material.dart';
import 'package:flutter_todo4/widgets/next_icon.dart';

class FirstView extends StatefulWidget {
  const FirstView({Key? key}) : super(key: key);

  @override
  State<FirstView> createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            //padding:const EdgeInsets.all(32),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/1.jpeg'), fit: BoxFit.cover)),
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(32),
                child: Text('Create and manage tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ]),
          ),
          Positioned(
              left: 0,
              right: 15,
              top: 65,
              bottom: 15,
              child: Align(
                alignment: Alignment.bottomRight,
                child: NextIcon(),
              ))
        ],
      ),
    );
  }
}
