import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomPersonAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;

  const CustomPersonAvatar({
    super.key,
    required this.imageUrl,
    this.size = 80.0, // Default size
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(), // Loading indicator
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error, // Error icon
            color: Colors.red,
            size: 40,
          ),
        ),
      ),
    );
  }
}
