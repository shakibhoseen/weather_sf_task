import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCacheImageShow extends StatelessWidget {
  final String? imageUrl;

  const CustomCacheImageShow({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '$imageUrl',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: downloadProgress.progress != null
              ? Text('${(downloadProgress.progress! *100).toStringAsFixed(2)} %')
              : const CircularProgressIndicator()),
      //placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      width: double.maxFinite,
      height: double.maxFinite,
    );
  }
}