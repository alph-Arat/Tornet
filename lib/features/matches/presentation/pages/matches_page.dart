import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tornet_assignment/app_icons_icons.dart';
import 'package:tornet_assignment/core/constants/app_colors.dart';
import 'package:tornet_assignment/core/constants/app_textstyles.dart';
import 'package:tornet_assignment/features/matches/presentation/bloc/carousel_cubit.dart';
import 'package:tornet_assignment/features/matches/presentation/bloc/matches_bloc.dart';
import 'package:tornet_assignment/features/matches/presentation/bloc/matches_state.dart';
import 'package:tornet_assignment/features/matches/presentation/widgets/competition_section.dart';
import 'package:tornet_assignment/features/matches/presentation/widgets/favorite_match_card.dart';
import 'package:tornet_assignment/features/matches/presentation/widgets/section_header.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchesBloc, MatchesState>(
      builder: (context, matchesState) {
        if (matchesState is MatchesLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.buttonSolid,
            ),
          );
        }

        if (matchesState is MatchesError) {
          return Center(
            child: Text(
              matchesState.message,
              style: AppTextstyles.content14.copyWith(color: Colors.red),
            ),
          );
        }

        if (matchesState is MatchesLoaded) {
          final selectedDayMatches = matchesState.matchesByDay.isNotEmpty
              ? matchesState.matchesByDay.first
              : null;

          if (selectedDayMatches == null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'No matches for this day',
                  style: AppTextstyles.content14,
                ),
              ),
            );
          }


          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                const SectionHeader(
                  icon: AppIcons.star,
                  iconColor: AppColors.buttonSolid,
                  title: "My Favorite Club",
                ),
                const Gap(12),
                if (selectedDayMatches.favClubMatches.isNotEmpty) ...[
                  BlocProvider(
                    create: (context) => CarouselCubit(),
                    child: BlocBuilder<CarouselCubit, int>(
                      builder: (context, carouselIndex) {
                        return Column(
                          children: [
                            CarouselSlider.builder(
                              itemCount: selectedDayMatches.favClubMatches.length,
                              itemBuilder: (context, index, realIndex) {
                                final match = selectedDayMatches.favClubMatches[index];
                                return FavoriteMatchCard(match: match);
                              },
                              options: CarouselOptions(
                                height: 166,
                                enlargeCenterPage: false,
                                enableInfiniteScroll: false,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  context.read<CarouselCubit>().changeIndex(index);
                                },
                              ),
                            ),
                            const Gap(12),
                            AnimatedSmoothIndicator(
                              activeIndex: carouselIndex,
                              count: selectedDayMatches.favClubMatches.length,
                              effect: const WormEffect(
                                dotWidth: 8,
                                dotHeight: 8,
                                spacing: 8,
                                activeDotColor: AppColors.buttonSolid,
                                dotColor: AppColors.gray,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
                const Gap(24),
                SectionHeader(
                  icon: AppIcons.ball,
                  iconColor: AppColors.buttonSolid,
                  title: "Leagues List",
                  trailing: Container(
                    width: 96,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.buttonSecond,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {},
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                AppIcons.search,
                                color: AppColors.white,
                                size: 18,
                              ),
                              const Gap(4),
                              Text(
                                "Search",
                                style: AppTextstyles.button12.copyWith(
                                  color: AppColors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(16),
                ...selectedDayMatches.competitions.map(
                  (competitionMatches) => CompetitionSection(
                    competitionMatches: competitionMatches,
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
