import 'package:flutter/material.dart';

import '../../../../../models/addon.dart';
import '../../../../../utility/constents.dart';

class ShowAddons extends StatelessWidget {
  final List<Addon> itemAddons;
   ShowAddons({super.key, required this.itemAddons});
  int numberOfAddon = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: itemAddons.map((e) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "${numberOfAddon++}- ${e.addonName}",
              style: TextStyle(color: kDarkSecondaryColor.withOpacity(0.8)),
            ),
          );
        }).toList(),
      ),
    );
  }
}

