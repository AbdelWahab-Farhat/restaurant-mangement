import 'package:flutter/material.dart';

import '../../../../../utility/app_style.dart';

class EmployeeCustomText extends StatelessWidget {
  final String title;
  const EmployeeCustomText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppStyle.textBodyMed,
    );
  }
}
