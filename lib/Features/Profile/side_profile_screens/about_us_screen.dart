import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:restaurant_management/core/widgets/custom_appbar.dart';
import 'package:restaurant_management/core/widgets/custom_cached_Image.dart';
import 'package:restaurant_management/utility/constents.dart';
import 'package:restaurant_management/utility/size_config.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'About Us', isCentred: false,hasBackButton: true,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                 CustomCachedImage(imageUrl: 'https://www.ultimatebeaver.com/wp-content/uploads/2017/02/Restaurant-page-template-heading.jpg'
                ,height: SizeConfig.screenHeight / 4.01,
                 width: SizeConfig.screenWidth,),
                Container(
                  height: 200,
                  color: Colors.black.withOpacity(0.3),
                ),
                const Positioned(
                  left: 20,
                  bottom: 20,
                  child: Text(
                    'Welcome to Our Restaurant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our Story',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kDarkPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'At our restaurant, we believe in providing the best dining experience for our customers. Our story began in 2024 with a mission to serve delicious food made from the finest ingredients. Our team is passionate about hospitality and we strive to create a welcoming atmosphere for all our guests.',
                    style: TextStyle(
                      fontSize: 16,
                      color: kDarkSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Our Vision',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kDarkPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Our vision is to become the leading restaurant in our community by consistently offering high-quality food and exceptional service. We aim to innovate and adapt to the changing culinary landscape while staying true to our core values.',
                    style: TextStyle(
                      fontSize: 16,
                      color: kDarkSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Follow Us',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kDarkPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(LineAwesomeIcons.facebook, color: kDarkPrimaryColor,size: 30),
                        onPressed: () {
                          // Add your Facebook URL here
                        },
                      ),
                      IconButton(
                        icon: const Icon(LineAwesomeIcons.instagram, color: kDarkPrimaryColor,size: 30,),
                        onPressed: () {
                          // Add your Instagram URL here
                        },
                      ),
                      IconButton(
                        icon: const Icon(LineAwesomeIcons.twitter, color: kDarkPrimaryColor,size: 30),
                        onPressed: () {
                          // Add your Twitter URL here
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
