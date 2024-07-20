import 'package:flutter/material.dart';

import '../../../../../utility/helpers.dart';
import '../../../../../utility/size_config.dart';

class HomeAdminBox extends StatelessWidget {
  final String image;
  final String viewName;
  final Widget view;
  const HomeAdminBox(
      {super.key,
      required this.image,
      required this.viewName,
      required this.view});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:  ()=> push(context, view),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height / 7.2,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 2),
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                )),
            const Spacer(),
            SizedBox(
                width: SizeConfig.screenWidth / 2,
                child: Text(
                  textAlign: TextAlign.center,
                  viewName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
