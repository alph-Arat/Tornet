import 'package:flutter/material.dart';
import 'package:tornet_assignment/core/constants/app_textstyles.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Home Page',
        style: AppTextstyles.title18,
      ),
    );
  }
}
