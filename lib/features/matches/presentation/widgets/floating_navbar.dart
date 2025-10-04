import 'package:flutter/material.dart';
import 'package:tornet_assignment/app_icons_icons.dart';
import 'package:tornet_assignment/core/constants/app_colors.dart';

class FloatingNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const FloatingNavbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14,12,14,20),
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            index: 0,
            icon: AppIcons.home,
          ),
          _buildNavItem(
            index: 1,
            icon: AppIcons.ball,
          ),
          _buildNavItem(
            index: 2,
            icon: AppIcons.tshirt,
          ),
          _buildNavItem(
            index: 3,
            icon: AppIcons.cup,
          ),
          _buildNavItem(
            index: 4,
            icon: AppIcons.category,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
  }) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        width: 68,
        height: 48,
        decoration: BoxDecoration(
          gradient: isSelected
              ? AppColors.buttonGradient
              : null,
          color: isSelected ? null : AppColors.white.withValues(alpha: 0.05),
         borderRadius: BorderRadius.circular(200)
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.black : AppColors.contentDark,
          size: 24,
        ),
      ),
    );
  }
}
