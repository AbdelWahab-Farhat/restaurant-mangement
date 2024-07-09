import 'package:flutter/material.dart';


class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Receipt'),),
      body: Column(
        children: [
          ListTile(title: Text(''),)
        ],
      ),
    );
  }
}
