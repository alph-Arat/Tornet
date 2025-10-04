import 'package:flutter/material.dart';
import 'package:tornet_assignment/core/constants/app_textstyles.dart';

class GridPage extends StatelessWidget {
  const GridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Grid Page',
        style: AppTextstyles.title18,
      ),
    );
  }
}
