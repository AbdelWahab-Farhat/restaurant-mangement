import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../utility/size_config.dart';
import '../../../root/presentation/views/root.dart';

class LoadingPaymentScreen extends StatelessWidget {
  const LoadingPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 5000)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset(
                    'lib/assets/animation_assets/Animation_payment.json',
                    animate: true,
                  ),
                ),
                SizedBox(width: SizeConfig.space * 2,),
                const Text('Payment Processing..',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return const Root();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }
}
