import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tornet_assignment/core/constants/app_colors.dart';
import 'package:tornet_assignment/core/constants/app_textstyles.dart';
import 'package:tornet_assignment/features/matches/domain/entities/live_match_event.dart';
import 'package:tornet_assignment/features/matches/domain/entities/match.dart';
import 'package:tornet_assignment/features/matches/presentation/bloc/live_match_cubit.dart';

class MatchListItem extends StatelessWidget {
  final Match match;
  final bool isLast;

  const MatchListItem({
    super.key,
    required this.match,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveMatchCubit, LiveMatchState>(
      builder: (context, liveState) {
        LiveMatchEvent? liveUpdate;

        if (match.apiId != null && match.apiId!.isNotEmpty) {
          liveUpdate = liveState.liveMatches[match.apiId];

          liveUpdate ??= liveState.liveMatches[match.apiId!.toLowerCase()];
          liveUpdate ??= liveState.liveMatches[match.apiId!.toUpperCase()];

          if (liveUpdate == null) {
            for (var entry in liveState.liveMatches.entries) {
              if (entry.key.contains(match.apiId!) || match.apiId!.contains(entry.key)) {
                liveUpdate = entry.value;
                break;
              }
            }
          }
        }

        final isLive = liveUpdate != null && liveUpdate.matchStatus >= 2 && liveUpdate.matchStatus <= 7;

        return Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: isLive ? AppColors.backgroundSP2 : AppColors.backgroundSP1,
            borderRadius: isLast
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  )
                : null,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        match.homeTeam.name,
                        style: AppTextstyles.content12,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Gap(8),
                    CachedNetworkImage(
                      imageUrl: match.homeTeam.shirt!,
                      height: 32,
                      width: 32,
                      memCacheWidth: 64,
                      memCacheHeight: 64,
                      maxWidthDiskCache: 64,
                      maxHeightDiskCache: 64,
                      errorWidget: (context, url, error) => const Icon(
                        Icons.sports_soccer,
                        size: 32,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              SizedBox(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (liveUpdate != null) ...[
                      Text(
                        '${liveUpdate.homeScore} - ${liveUpdate.awayScore}',
                        style: AppTextstyles.title12.copyWith(
                          color: isLive ? AppColors.buttonSolid : AppColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (isLive)
                        Text(
                          liveUpdate.matchStatusDescription,
                          style: AppTextstyles.content12.copyWith(
                            fontSize: 9,
                            color: AppColors.buttonSolid,
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ] else
                      Text(
                        match.matchTime,
                        style: AppTextstyles.title12,
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
              const Gap(8),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: match.awayTeam.shirt!,
                      height: 32,
                      width: 32,
                      memCacheWidth: 64,
                      memCacheHeight: 64,
                      maxWidthDiskCache: 64,
                      maxHeightDiskCache: 64,
                      errorWidget: (context, url, error) => const Icon(
                        Icons.sports_soccer,
                        size: 32,
                        color: AppColors.white,
                      ),
                    ),
                    const Gap(8),
                    Flexible(
                      child: Text(
                        match.awayTeam.name,
                        style: AppTextstyles.content12,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
