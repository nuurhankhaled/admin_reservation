import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ViewFeatureScreen extends StatelessWidget {
  const ViewFeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("reservationApp".tr()),
      ),
      body: Center(
        child: Text("View Screen"),
      ),
    );
  }
}
