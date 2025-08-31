import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/widgets/my_drawer.dart';
import 'package:steam/features/home/presentation/widgets/main_page_card.dart';
import 'package:steam/core/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          width: 150,
          height: 150,
        ),
        actions: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 40, bottom: 10),
                child: Image.asset(
                  'assets/images/image2.png',
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
                    color: AppColors.myGrey3,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    spacing: 8,
                    children: [
                      Text(
                        '۲۲۰',
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
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            MainPageCard(),
            MainPageCard(),
            MainPageCard(),
            MainPageCard(),
          ],
        ),
      ),
    );
  }
}
