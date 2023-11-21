import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TiImage extends StatelessWidget {
  final String? url;
  const TiImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url.toString(),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter:
                  ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
        ),
      ),
      errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
    );
  }
}
