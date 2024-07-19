
import 'package:flutter/material.dart';

class AddonWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;

  const AddonWidget({super.key,
    required this.nameController,
    required this.priceController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Addon Name'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
