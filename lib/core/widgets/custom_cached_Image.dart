import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';



class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  const CustomCachedImage({super.key, required this.imageUrl, this.width, this.height});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:imageUrl,
      progressIndicatorBuilder:
          (context, url, downloadProgress) =>
          CircularProgressIndicator(
              value: downloadProgress.progress),
      errorWidget: (context, url, error) =>
      const Icon(Icons.error),
      width: width ?? 100,
      height: height ?? 100,
      fit: BoxFit.cover,
    );
  }
}
