import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tornet_assignment/core/constants/app_colors.dart';
import 'package:tornet_assignment/features/matches/data/datasources/matches_remote_datasource.dart';
import 'package:tornet_assignment/features/matches/data/datasources/websocket_service.dart';
import 'package:tornet_assignment/features/matches/data/repositories/matches_repository_impl.dart';
import 'package:tornet_assignment/features/matches/domain/usecases/get_matches_by_day.dart';
import 'package:tornet_assignment/features/matches/presentation/bloc/live_match_cubit.dart';
import 'package:tornet_assignment/features/matches/presentation/bloc/matches_bloc.dart';
import 'package:tornet_assignment/features/matches/presentation/bloc/matches_event.dart';
import 'package:tornet_assignment/features/matches/presentation/bloc/navbar_cubit.dart';
import 'package:tornet_assignment/features/matches/presentation/bloc/tab_cubit.dart';
import 'package:tornet_assignment/features/matches/presentation/widgets/custom_appbar.dart';
import 'package:tornet_assignment/features/matches/presentation/widgets/floating_navbar.dart';
import 'package:tornet_assignment/features/matches/presentation/pages/home_page_content.dart';
import 'package:tornet_assignment/features/matches/presentation/pages/matches_page.dart';
import 'package:tornet_assignment/features/matches/presentation/pages/shirt_page.dart';
import 'package:tornet_assignment/features/matches/presentation/pages/trophy_page.dart';
import 'package:tornet_assignment/features/matches/presentation/pages/grid_page.dart';

class HomePage extends StatelessWidget {
  final String token;

  const HomePage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final today = DateTime.now();
            final formattedDate =
                '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

            return MatchesBloc(
              getMatchesByDay: GetMatchesByDay(
                MatchesRepositoryImpl(
                  remoteDataSource: MatchesRemoteDataSourceImpl(
                    client: http.Client(),
                  ),
                ),
              ),
            )..add(FetchMatchesByDay(token: token, date: formattedDate));
          },
        ),
        BlocProvider(
          create: (context) => TabCubit()..changeTab(7), // Today is at index 7
        ),
        BlocProvider(
          create: (context) => NavbarCubit(), // Default is center (index 1)
        ),
        BlocProvider(
          create: (context) => LiveMatchCubit(WebSocketService()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              onTabChanged: (index) {
                context.read<TabCubit>().changeTab(index);

                // Calculate the date for the selected tab and fetch matches
                final dateOffset = index - 7; // 7 is today's index
                final selectedDate =
                    DateTime.now().add(Duration(days: dateOffset));
                final formattedDate =
                    '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';

                context.read<MatchesBloc>().add(
                      FetchMatchesByDay(token: token, date: formattedDate),
                    );
              },
            ),
            backgroundColor: AppColors.mainBackground,
            body: BlocBuilder<NavbarCubit, int>(
              builder: (context, selectedIndex) {
                switch (selectedIndex) {
                  case 0:
                    return const HomePageContent();
                  case 1:
                    return const MatchesPage();
                  case 2:
                    return const ShirtPage();
                  case 3:
                    return const TrophyPage();
                  case 4:
                    return const GridPage();
                  default:
                    return const MatchesPage();
                }
              },
            ),
            bottomNavigationBar: BlocBuilder<NavbarCubit, int>(
              builder: (context, selectedIndex) {
                return FloatingNavbar(
                  selectedIndex: selectedIndex,
                  onItemTapped: (index) {
                    context.read<NavbarCubit>().changeIndex(index);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
