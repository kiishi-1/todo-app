import 'package:flutter/material.dart';
import 'package:flutter_todo4/screens/home_view.dart';

class NextIcon extends StatelessWidget {
  const NextIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeView()));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[800],
        ),
        height: 40,
        width: 100,
        child: Row(
          children: [
            Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 12,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white38,
              size: 11,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white24,
              size: 11,
            )
          ],
        ),
      ),
    );
  }
}
