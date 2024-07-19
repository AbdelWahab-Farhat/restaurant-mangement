import 'package:flutter/material.dart';

import '../../../../../utility/size_config.dart';

class ToggleAuthView extends StatelessWidget {
  final String questionText;
  final String viewText;
  final void Function() onTap;
  const ToggleAuthView({
    super.key, required this.questionText, required this.viewText, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          questionText,
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
        SizedBox(
          width: SizeConfig.space * 0.5,
        ),
        GestureDetector(
          onTap: onTap ,
          child:  Text(
            viewText,
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
