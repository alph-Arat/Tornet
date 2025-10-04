import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tornet_assignment/core/constants/app_colors.dart';
import 'package:tornet_assignment/core/constants/app_textstyles.dart';
import 'package:tornet_assignment/features/matches/presentation/bloc/live_match_cubit.dart';

class ShirtPage extends StatefulWidget {
  const ShirtPage({super.key});

  @override
  State<ShirtPage> createState() => _ShirtPageState();
}

class _ShirtPageState extends State<ShirtPage> {
  late LiveMatchCubit _liveMatchCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _liveMatchCubit = context.read<LiveMatchCubit>();
    _liveMatchCubit.connect();
  }

  @override
  void dispose() {
    _liveMatchCubit.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveMatchCubit, LiveMatchState>(
      builder: (context, liveState) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (liveState.liveMatches.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.buttonSolid,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Live Matches (${liveState.liveMatches.length})',
                        style: AppTextstyles.headlineH6.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      const Gap(8),
                      ...liveState.liveMatches.values.map((liveEvent) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            'ID: ${liveEvent.matchApiId} • ${liveEvent.matchStatusDescription} • ${liveEvent.homeScore} - ${liveEvent.awayScore}',
                            style: AppTextstyles.content12.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                )
              else
                const Center(
                  child: Text(
                    'No live matches',
                    style: AppTextstyles.title18,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
