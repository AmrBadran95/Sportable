import 'package:sportable/Services/cubits/leagues_cubit/leagues_cubit.dart';
import 'package:sportable/Services/utils/globals.dart';
import 'package:sportable/data/repos/leagues_repo.dart';
import 'package:sportable/presentation/screens/teams_topscorers_tab_screen.dart';
import 'package:sportable/presentation/widgets/layout_with_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaguesScreen extends StatelessWidget {
  final int? countryId;
  const LeaguesScreen({super.key, required this.countryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create:
            (context) => LeaguesCubit(LeaguesRepo())..fetchLeagues(countryId!),
        child: BlocBuilder<LeaguesCubit, LeaguesState>(
          builder: (context, state) {
            if (state is LeaguesLoading) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Globals.secondaryColor,
                  strokeWidth: 3,
                ),
              );
            } else if (state is LeaguesError) {
              return Center(child: Text(state.error.toString()));
            } else if (state is LeaguesSuccess) {
              final league = state.leaguesResponse.result;
              return LayoutWithDrawer(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Container(
                        width: Globals.fullSize(context).width,
                        height: 200,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Globals.secondaryBackground,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              league[0]?.countryLogo ?? "",
                              height: 120,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.broken_image, size: 80);
                              },
                            ),
                            SizedBox(height: 12),
                            Text(
                              league[0]?.countryName ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Globals.darkFont,
                                fontSize: Globals.title,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (var i = 0; i < league.length; i++) ...[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (BuildContext context) =>
                                                TeamsTopscorersTabScreen(
                                                  leagueId:
                                                      league[0]?.leagueKey,
                                                ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Globals.secondaryBackground,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            league[i]?.leagueName ?? "",
                                            style: TextStyle(
                                              color: Globals.darkFont,
                                              fontSize: Globals.title,
                                            ),
                                          ),
                                          Image.network(
                                            league[i]?.leagueLogo ?? "",
                                            width: 60,
                                            height: 50,
                                            fit: BoxFit.contain,

                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              return Icon(
                                                Icons.broken_image,
                                                size: 60,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Text("Failed to get Leagues data"));
            }
          },
        ),
      ),
    );
  }
}
