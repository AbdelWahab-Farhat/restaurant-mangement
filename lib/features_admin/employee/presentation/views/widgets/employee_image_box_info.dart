import 'package:flutter/material.dart';

import '../../../../../utility/app_style.dart';

class EmployeeImageBoxInfo extends StatelessWidget {
  const EmployeeImageBoxInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Employee Photo',
          style: AppStyle.textBodySmall.copyWith(fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        const Icon(
          Icons.camera_alt_sharp,
          size: 29,
          color: Colors.black54,
        )
      ],
    );
  }
}
