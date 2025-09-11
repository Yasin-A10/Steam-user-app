import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/utils/number_formater.dart';
import 'package:steam/core/widgets/button.dart';
import 'package:steam/core/widgets/social_icon_list.dart';
import 'package:steam/features/home/data/model/content_post_model.dart';
import 'package:steam/features/home/presentation/widgets/expandable_text.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPageCard extends StatelessWidget {
  final PostData post;
  const MainPageCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _handleCardModal(context, post);
                      },
                      child: post.owner.picture != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                post.owner.picture!,
                                width: 54,
                                height: 54,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              'assets/images/image4.png',
                              width: 54,
                              height: 54,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.owner.fullName ?? 'بدون نام',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.myGrey,
                          ),
                        ),
                        Text(
                          post.owner.biography ?? 'بدون توضیحات',
                          style: TextStyle(
                            color: AppColors.myGrey2,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.myGrey5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        spacing: 8,
                        children: [
                          Text(
                            formatNumberToPersian(post.coinBalance ?? 0),
                            style: TextStyle(
                              color: AppColors.yellow,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Icon(
                            HugeIcons.strokeRoundedDollar02,
                            color: AppColors.yellow,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(
                post.title ?? 'خالی',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.myGrey,
                ),
              ),
              ExpandableText(text: post.body ?? 'خالی', trimLength: 200),
            ],
          ),
        ),
        post.link == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Button(
                  label: post.linkTitle ?? 'بدون لینک',
                  onPressed: () async {
                    final url = post.link;
                    if (url != null && url.isNotEmpty) {
                      final uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('لینک قابل باز شدن نیست'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('لینک قابل باز شدن نیست'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  width: double.infinity,
                  backgroundColor: AppColors.orangeLight,
                  textColor: AppColors.orange,
                ),
              ),

        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: post.contents!.length,
            itemBuilder: (context, index) {
              final content = post.contents![index];
              final hasPreview =
                  content.preview != null && content.preview!.isNotEmpty;

              return InkWell(
                onTap: () {
                  if (hasPreview) {
                    GoRouter.of(
                      context,
                    ).push('/video-player', extra: content.content!);
                  } else {
                    GoRouter.of(
                      context,
                    ).push('/image-viewer', extra: content.content!);
                  }
                },
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          hasPreview ? content.preview! : content.content!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (hasPreview)
                        const Center(
                          child: Icon(
                            HugeIcons.strokeRoundedPlayCircle02,
                            size: 36,
                            color: AppColors.blueLight,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 8),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Divider(color: AppColors.myGrey5, thickness: 1),
        ),
      ],
    );
  }
}

void _handleCardModal(BuildContext context, PostData post) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  transform: GradientRotation(0.4),
                  colors: [
                    Color(0xFFF9A825).withValues(alpha: 0.4),
                    Colors.black.withValues(alpha: 0.1),
                    Color(0xFF00ACC1).withValues(alpha: 0.4),
                  ],
                  stops: [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 20,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  spacing: 16,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    post.owner.picture != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              post.owner.picture!,
                              height: 185,
                              width: 185,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            'assets/images/image2.png',
                            height: 185,
                            width: 185,
                            fit: BoxFit.cover,
                          ),
                    Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          post.owner.fullName ?? 'بدون نام',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.myGrey,
                          ),
                        ),
                        Text(
                          post.owner.biography ?? 'بدون توضیحات',
                          style: TextStyle(
                            color: AppColors.myGrey2,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 8,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Text(
                              post.owner.fullName ?? 'بدون نام',
                              style: TextStyle(
                                color: AppColors.myGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Icon(
                              HugeIcons.strokeRoundedCall02,
                              color: AppColors.myGrey2,
                              size: 24,
                            ),
                          ],
                        ),
                        Row(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              post.owner.biography ?? 'بدون توضیحات',
                              style: TextStyle(
                                color: AppColors.myGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Icon(
                              HugeIcons.strokeRoundedMail01,
                              color: AppColors.myGrey2,
                              size: 24,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SocialIconList(),
                    post.linkTitle != null
                        ? Button(
                            onPressed: () {},
                            label: post.linkTitle ?? 'بدون لینک',
                            textColor: AppColors.orange,
                            backgroundColor: AppColors.orangeLight,
                            width: double.infinity,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
