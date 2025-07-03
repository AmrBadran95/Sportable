import 'package:sportable/Services/cubits/search_teams_cubit/search_teams_cubit.dart';
import 'package:sportable/Services/cubits/teams_cubit.dart/teams_cubit.dart';
import 'package:sportable/Services/cubits/topscorers_cubit.dart/topscorers_cubit.dart';
import 'package:sportable/Services/utils/globals.dart';
import 'package:sportable/data/repos/teams_repo.dart';
import 'package:sportable/data/repos/topscorers_repo.dart';
import 'package:sportable/presentation/widgets/layout_with_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportable/presentation/pages/teams_with_search.dart';
import 'package:sportable/presentation/pages/top_scorers.dart';

class TeamsTopscorersTabScreen extends StatelessWidget {
  final int? leagueId;
  const TeamsTopscorersTabScreen({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TeamsCubit(TeamsRepo())..fetchTeams(leagueId!),
        ),
        BlocProvider(create: (context) => SearchTeamsCubit()),
        BlocProvider(
          create:
              (context) =>
                  TopscorersCubit(TopscorersRepo())..fetchTopscorers(leagueId!),
        ),
      ],
      child: LayoutWithDrawer(
        child: Container(
          color: Globals.primaryBackground,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  color: Globals.primaryColor,
                  child: TabBar(
                    indicatorColor: Globals.lightFont,
                    labelColor: Globals.darkFont,
                    labelStyle: TextStyle(
                      fontSize: Globals.title,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: TextStyle(fontSize: Globals.subtitle),
                    unselectedLabelColor: Globals.lightFont,
                    tabs: [Tab(text: 'Teams'), Tab(text: 'Top Scorers')],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      TeamsWithSearch(leagueId: leagueId!),
                      TopScorers(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
