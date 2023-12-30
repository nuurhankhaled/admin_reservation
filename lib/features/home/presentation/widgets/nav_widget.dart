import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavWidget extends StatefulWidget {
  NavWidget({super.key, required this.text});
  String text;
  @override
  State<NavWidget> createState() => _NavWidgetState();
}

Color buttonColor = Colors.transparent; // Initial color for buttons

class _NavWidgetState extends State<NavWidget> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          buttonColor = Colors.grey;
        });
      },
      onExit: (_) {
        setState(() {
          buttonColor = Colors.transparent;
        });
      },
      child: Container(
        width: double.infinity,
        height: 18.h,
        child: InkWell(
          onTap: () {
            // Handle button press
            setState(() {
              buttonColor = Colors.blue;
            });
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: buttonColor,
            child: Column(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
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
