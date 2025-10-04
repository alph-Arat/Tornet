import 'package:flutter/material.dart';
import 'package:tornet_assignment/core/constants/app_textstyles.dart';

class TrophyPage extends StatelessWidget {
  const TrophyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Trophy Page',
        style: AppTextstyles.title18,
      ),
    );
  }
}
