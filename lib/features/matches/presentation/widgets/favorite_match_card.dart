import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tornet_assignment/core/constants/app_colors.dart';
import 'package:tornet_assignment/core/constants/app_images.dart';
import 'package:tornet_assignment/core/constants/app_textstyles.dart';
import 'package:tornet_assignment/features/matches/domain/entities/match.dart';

class FavoriteMatchCard extends StatelessWidget {
  final Match match;

  const FavoriteMatchCard({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppImages.favorite),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  children: [
                    if (match.homeTeam.shirt!.isNotEmpty)
                      CachedNetworkImage(
                        imageUrl: match.homeTeam.shirt!,
                        width: 48,
                        height: 48,
                        memCacheWidth: 96,
                        memCacheHeight: 96,
                        maxWidthDiskCache: 96,
                        maxHeightDiskCache: 96,
                        placeholder: (context, url) => const SizedBox(
                          width: 48,
                          height: 48,
                          child: Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.buttonSolid,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.sports_soccer,
                          size: 48,
                          color: AppColors.white,
                        ),
                      ),
                    const Gap(8),
                    Text(
                      match.homeTeam.name,
                      style: AppTextstyles.title12,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(
                match.matchTime,
                style: AppTextstyles.headlineH5,
              ),
              Expanded(
                child: Column(
                  children: [
                    if (match.awayTeam.shirt!.isNotEmpty)
                      CachedNetworkImage(
                        imageUrl: match.awayTeam.shirt!,
                        width: 48,
                        height: 48,
                        memCacheWidth: 96,
                        memCacheHeight: 96,
                        maxWidthDiskCache: 96,
                        maxHeightDiskCache: 96,
                        placeholder: (context, url) => const SizedBox(
                          width: 48,
                          height: 48,
                          child: Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.buttonSolid,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.sports_soccer,
                          size: 48,
                          color: AppColors.white,
                        ),
                      ),
                    const Gap(8),
                    Text(
                      match.awayTeam.name,
                      style: AppTextstyles.title12,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: 182,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.mainBackground,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Text(
                "Predict Now",
                style: AppTextstyles.title12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
