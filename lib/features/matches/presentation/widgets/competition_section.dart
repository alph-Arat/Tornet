import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tornet_assignment/core/constants/app_colors.dart';
import 'package:tornet_assignment/core/constants/app_textstyles.dart';
import 'package:tornet_assignment/features/matches/domain/entities/competition_matches.dart';
import 'package:tornet_assignment/features/matches/presentation/widgets/match_list_item.dart';

class CompetitionSection extends StatelessWidget {
  final CompetitionMatches competitionMatches;

  const CompetitionSection({
    super.key,
    required this.competitionMatches,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.backgroundSP2,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Row(
              children: [
                if (competitionMatches.competition.image.isNotEmpty)
                  CachedNetworkImage(
                    imageUrl: competitionMatches.competition.image,
                    width: 24,
                    height: 24,
                    memCacheWidth: 48,
                    memCacheHeight: 48,
                    maxWidthDiskCache: 48,
                    maxHeightDiskCache: 48,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.sports_soccer,
                      size: 24,
                      color: AppColors.buttonSolid,
                    ),
                  ),
                const Gap(8),
                SizedBox(
                  width: 200,
                  child: Text(
                    competitionMatches.competition.name,
                    style: AppTextstyles.title12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 100,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.buttonSolid,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Predict Now",
                      style: AppTextstyles.button12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...competitionMatches.matches.asMap().entries.map(
            (entry) => MatchListItem(
              match: entry.value,
              isLast: entry.key == competitionMatches.matches.length - 1,
            ),
          ),
        ],
      ),
    );
  }
}
