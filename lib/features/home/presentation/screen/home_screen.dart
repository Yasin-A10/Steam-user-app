import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/utils/number_formater.dart';
import 'package:steam/core/widgets/my_drawer.dart';
import 'package:steam/features/home/data/model/content_post_model.dart';
import 'package:steam/features/home/presentation/bloc/content_bloc.dart';
import 'package:steam/features/home/presentation/widgets/main_page_card.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/features/profile/domain/entity/user_entity.dart';
import 'package:steam/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:steam/features/profile/presentation/bloc/profile_status.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  int limit = 10;

  final List<PostData> _allPosts = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContentBloc>(
      context,
    ).add(LoadContentEvent(page: page, pageSize: limit));
    BlocProvider.of<ProfileBloc>(context).add(LoadProfileEvent());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      page += 1;
      BlocProvider.of<ContentBloc>(
        context,
      ).add(LoadContentEvent(page: page, pageSize: limit));
    }
  }

  bool get _isBottom {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.99);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        toolbarHeight: 80,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(HugeIcons.strokeRoundedMenu03),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        title: SvgPicture.asset(
          'assets/images/steam.svg',
          width: 120,
          height: 120,
        ),
        actions: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state.profileStatus is ProfileLoading) {
                return Center(
                  child: LoadingAnimationWidget.flickr(
                    leftDotColor: AppColors.orange,
                    rightDotColor: AppColors.blue,
                    size: 28,
                  ),
                );
              }
              if (state.profileStatus is ProfileError) {
                return Center(
                  child: Text(
                    (state.profileStatus as ProfileError).message,
                    style: const TextStyle(color: AppColors.error200),
                  ),
                );
              }
              if (state.profileStatus is ProfileSuccess) {
                final ProfileSuccess profileSuccess =
                    state.profileStatus as ProfileSuccess;
                final UserEntity user = profileSuccess.userEntity;
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 30,
                        bottom: 10,
                      ),
                      child: user.picture != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: user.picture!,
                                width: 54,
                                height: 54,
                                fit: BoxFit.cover,
                                fadeInDuration: const Duration(
                                  milliseconds: 500,
                                ),
                                placeholder: (context, url) => Container(
                                  width: 54,
                                  height: 54,
                                  alignment: Alignment.center,
                                  child: LoadingAnimationWidget.flickr(
                                    leftDotColor: AppColors.orange,
                                    rightDotColor: AppColors.blue,
                                    size: 24,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                      'assets/images/image1.png',
                                      width: 54,
                                      height: 54,
                                      fit: BoxFit.cover,
                                    ),
                              ),
                            )
                          : Image.asset(
                              'assets/images/image4.png',
                              width: 43,
                              height: 43,
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.myGrey7,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          spacing: 8,
                          children: [
                            Text(
                              formatNumberToPersian(user.walletBalance ?? 0),
                              style: TextStyle(
                                color: AppColors.yellow,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/icons/coin.svg',
                              width: 24,
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),

      body: BlocConsumer<ContentBloc, ContentState>(
        listener: (context, state) {
          if (state is ContentSuccess) {
            final newPosts = state.contentPostModel.results.postData;
            setState(() {
              _allPosts.addAll(newPosts);
            });
          }
        },
        builder: (context, state) {
          if (_allPosts.isEmpty && state is ContentLoading) {
            return Center(
              child: LoadingAnimationWidget.twoRotatingArc(
                color: AppColors.orange,
                size: 32,
              ),
            );
          }
          if (state is ContentError && _allPosts.isEmpty) {
            return Center(child: Text(state.message));
          }

          return ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            itemCount: _allPosts.length + 1,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              if (index < _allPosts.length) {
                final post = _allPosts[index];
                return MainPageCard(post: post);
              } else {
                if (state is ContentLoading) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: LoadingAnimationWidget.twoRotatingArc(
                        color: AppColors.orange,
                        size: 32,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }
            },
          );
        },
      ),
    );
  }
}
