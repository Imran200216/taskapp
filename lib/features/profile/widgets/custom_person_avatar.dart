import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/gen/assets.gen.dart';

class CustomPersonAvatar extends StatelessWidget {
  final String imageUrl;
  final double? size;
  final String placeholderImage;

  CustomPersonAvatar({
    super.key,
    required this.imageUrl,
    this.size,
    String? placeholderImage,
  }) : placeholderImage =
           placeholderImage ?? Assets.img.jpg.profilePlaceholder.path;

  @override
  Widget build(BuildContext context) {
    //  avatar size
    double avatarSize = size ?? 74.0.h;

    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder:
              (context, url) =>
                  Image.asset(placeholderImage, fit: BoxFit.cover),
          errorWidget:
              (context, url, error) =>
                  Image.asset(placeholderImage, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
