import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:steam/core/constants/colors.dart';

class ImageViewScreen extends StatelessWidget {
  final String imageUrl;
  const ImageViewScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        title: Text('نمایش تصویر', style: TextStyle(color: AppColors.white)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            HugeIcons.strokeRoundedArrowRight01,
            color: AppColors.white,
          ),
        ),
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.contain,
          fadeInDuration: const Duration(milliseconds: 500),
          placeholder: (context, url) => LoadingAnimationWidget.hexagonDots(
            color: AppColors.orange,
            size: 50,
          ),
          errorWidget: (context, url, error) =>
              Icon(HugeIcons.strokeRoundedWifiError01),
        ),
      ),
    );
  }
}
