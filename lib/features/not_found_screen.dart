import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/widgets/button.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'صفحه مورد نظر پیدا نشد!',
          style: TextStyle(color: AppColors.orange),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 350,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/not_found.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Button(
                onPressed: () => context.go('/'),
                label: 'خانه',
                textColor: AppColors.white,
                backgroundColor: AppColors.orange,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
