import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../core/widgets/custom_cached_Image.dart';
import '../../../utility/size_config.dart';




class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'restaurant-hero',
                  child:CustomCachedImage(imageUrl: 'https://www.ultimatebeaver.com/wp-content/uploads/2017/02/Restaurant-page-template-heading.jpg'
                    ,height: SizeConfig.screenHeight / 4.01,
                    width: SizeConfig.screenWidth,),

                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Monkey Restaurant',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red),
                      const SizedBox(width: 4),
                      Text(
                        '123 Banana Street, Monkeyville, Jungleland',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < 4 ? Icons.star : Icons.star_half,
                        color: Colors.amber,
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'About the Restaurant',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Monkey Restaurant is known for its exotic flavors and vibrant ambiance. '
                        'Nestled in the heart of Monkeyville, it offers a delightful escape '
                        'into a culinary paradise. Whether you\'re in the mood for traditional '
                        'delicacies or contemporary dishes, Monkey Restaurant has something for everyone.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Specialties',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(LineAwesomeIcons.utensils_solid, size: 40, color: Colors.red),
                          SizedBox(height: 8),
                          Text('Exotic Dishes'),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(LineAwesomeIcons.wine_glass_solid, size: 40, color: Colors.red),
                          SizedBox(height: 8),
                          Text('Fine Wines'),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(LineAwesomeIcons.cocktail_solid, size: 40, color: Colors.red),
                          SizedBox(height: 8),
                          Text('Signature Cocktails'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Reviews',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ReviewTile(
                    username: 'John Doe',
                    review: 'Amazing food and fantastic ambiance! Highly recommend.',
                    rating: 5,
                  ),
                  ReviewTile(
                    username: 'Jane Smith',
                    review: 'A wonderful dining experience. Will definitely come back.',
                    rating: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewTile extends StatelessWidget {
  final String username;
  final String review;
  final int rating;

  ReviewTile({
    required this.username,
    required this.review,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              );
            }),
          ),
          const SizedBox(height: 4),
          Text(
            review,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
