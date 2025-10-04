import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tornet_assignment/core/constants/app_textstyles.dart';

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: trailing != null ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        const Gap(8),
        Text(
          title,
          style: AppTextstyles.title18,
        ),
        if (trailing != null) ...[
          const Spacer(),
          trailing!,
        ],
      ],
    );
  }
}
