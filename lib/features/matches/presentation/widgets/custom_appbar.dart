import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tornet_assignment/app_icons_icons.dart';
import 'package:tornet_assignment/core/constants/app_colors.dart';
import 'package:tornet_assignment/core/constants/app_images.dart';
import 'package:tornet_assignment/core/constants/app_textstyles.dart';
import 'package:tornet_assignment/features/matches/presentation/bloc/tab_cubit.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final double height;
  final Function(int)? onTabChanged;

  const CustomAppBar({
    super.key,
    this.actions,
    this.height = 160,
    this.onTabChanged,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late ScrollController _scrollController;
  static const int todayIndex = 7; // Today is at index 7 (after 7 days before)

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final screenWidth = MediaQuery.of(context).size.width;
        final itemWidth = 60.0; 
        final centerOffset = (todayIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);
        _scrollController.jumpTo(centerOffset.clamp(0.0, _scrollController.position.maxScrollExtent));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _getDaysWithDates() {
    final now = DateTime.now();
    final List<Map<String, String>> daysData = [];

    // Generate 2 weeks: 7 days before today + today + 6 days after = 14 days
    for (int i = -7; i <= 6; i++) {
      final date = now.add(Duration(days: i));
      String dayName;

      if (i == -1) {
        dayName = 'Yesterday';
      } else if (i == 0) {
        dayName = 'Today';
      } else if (i == 1) {
        dayName = 'Tomorrow';
      } else {
        dayName = _getDayName(date.weekday);
      }

      daysData.add({
        'name': dayName,
        'date': '${date.day.toString().padLeft(2, '0')} ${_getMonthName(date.month)}',
      });
    }

    return daysData;
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final daysData = _getDaysWithDates();

    return Container(
        height: 210 + topPadding,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
          border: Border.all(
              width: 1, color: AppColors.white.withValues(alpha: 0.25)),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                AppImages.top,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: topPadding,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundSP1,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      AppIcons.calendar,
                      color: AppColors.buttonSolid,
                    ),
                  ),
                  const Gap(40),
                  Column(
                    children: [
                      Text(
                        "0",
                        style: AppTextstyles.title20,
                      ),
                      const Text(
                        "Points",
                        style: AppTextstyles.title12,
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        "0",
                        style: AppTextstyles.title20,
                      ),
                      const Text(
                        "Coins",
                        style: AppTextstyles.title12,
                      )
                    ],
                  ),
                  const Gap(40),
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundSP1,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      AppIcons.buy,
                      color: AppColors.buttonSolid,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Transform.translate(
                offset: const Offset(0, -25),
                child: Container(
                  height: 18,
                  width: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.003, 0.3569, 0.676, 1.0],
                      colors: [
                        Color(0xFF484C51),
                        Color(0xFF2E3236),
                        Color(0xFF454E57),
                        Color(0xFF1A1E23),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "12",
                            style: AppTextstyles.title14,
                          ),
                          const TextSpan(
                            text: "th",
                            style: AppTextstyles.title12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Transform.translate(
                offset: const Offset(20, 30),
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.mainBackground, width: 2),
                    gradient: const LinearGradient(
                      stops: [
                        0.003,
                        0.3569,
                        0.676,
                        1.0
                      ],
                      colors: [
                        Color(0xFF484C51),
                        Color(0xFF2E3236),
                        Color(0xFF454E57),
                        Color(0xFF1A1E23),
                      ],
                      transform: GradientRotation(100.64 * 3.1416 / 180),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.gold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BlocBuilder<TabCubit, int>(
                builder: (context, selectedIndex) {
                  return SizedBox(
                    height: 44,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: daysData.length,
                      itemBuilder: (context, index) {
                        final isSelected = selectedIndex == index;
                        final dayData = daysData[index];
                        return GestureDetector(
                          onTap: () {
                            context.read<TabCubit>().changeTab(index);
                            widget.onTabChanged?.call(index);
                          },
                          child: Container(
                            width: 60,
                            margin: const EdgeInsets.only(right: 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  dayData['name']!,
                                  style: isSelected
                                      ? AppTextstyles.title12.copyWith(
                                          color: AppColors.buttonSolid,
                                        )
                                      : AppTextstyles.content12.copyWith(color: AppColors.placeholder),
                                  textAlign: TextAlign.center,
                                ),
                                const Gap(4),
                                Text(
                                  dayData['date']!,
                                  style: isSelected
                                      ? AppTextstyles.title12.copyWith(
                                          color: AppColors.buttonSolid,
                                        )
                                      : AppTextstyles.content12,
                                ),
                                const Gap(4),
                                Container(
                                  height: 2,
                                  width: 40,
                                  color: isSelected? AppColors.buttonSolid: null,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}
