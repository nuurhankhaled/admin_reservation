import 'package:flutter/material.dart';

import 'custom_texts.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errMessage});
  final String errMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text14(
        text: errMessage,
      ),
    );
  }
}
