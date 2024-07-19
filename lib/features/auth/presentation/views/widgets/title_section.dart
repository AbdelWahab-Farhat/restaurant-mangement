import 'package:flutter/material.dart';
import 'package:restaurant_management/utility/app_assets.dart';
import '../../../../../utility/app_style.dart';
import '../../../../../utility/size_config.dart';

class TitleSection extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  const TitleSection({super.key, required this.titleText, required this.subTitleText});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
         Text(
           textAlign: TextAlign.center,
          titleText,
          style: AppStyle.textBodyBig,
                 ),
        SizedBox(
          height: SizeConfig.space,
        ),
        // Sub title
        Text(subTitleText,
          textAlign: TextAlign.center,
          style: AppStyle.textBodySmall.copyWith(fontSize: 16,color: Colors.black.withOpacity(0.6)),
        ),
        // Logo
        SizedBox(
          height: SizeConfig.space,
        ),
         SizedBox(
             height: 150,
             width: 200,
             child: Image.asset(AppAssets.LOGO_PATH,
             fit: BoxFit.cover,
             ),),
      ],
    );
  }
}