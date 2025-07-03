import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportable/Services/cubits/search_teams_cubit/search_teams_cubit.dart';
import 'package:sportable/Services/cubits/teams_cubit.dart/teams_cubit.dart';
import 'package:sportable/Services/utils/globals.dart';
import 'package:sportable/data/models/teams_model.dart';
import 'package:sportable/presentation/screens/players_screen.dart';
import 'package:sportable/presentation/widgets/search_field.dart';

class TeamsWithSearch extends StatelessWidget {
  final int leagueId;
  const TeamsWithSearch({super.key, required this.leagueId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeamsCubit, TeamsState>(
      listenWhen: (previous, current) => current is TeamsSuccess,
      listener: (context, state) {
        if (state is TeamsSuccess) {
          context.read<SearchTeamsCubit>().setAllTeams(
            state.teamsResponse!.result,
          );
        }
      },
      child: BlocBuilder<TeamsCubit, TeamsState>(
        builder: (context, state) {
          if (state is TeamsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Globals.secondaryColor,
                strokeWidth: 3,
              ),
            );
          } else if (state is TeamsError) {
            return Center(child: Text(state.error.toString()));
          } else if (state is TeamsSuccess) {
            final List<Team?> teams = state.teamsResponse!.result;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Search(
                    onChanged:
                        (query) =>
                            context.read<SearchTeamsCubit>().search(query),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<SearchTeamsCubit, SearchTeamsState>(
                    builder: (context, state) {
                      if (state is SearchTeamsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Globals.secondaryColor,
                            strokeWidth: 3,
                          ),
                        );
                      } else if (state is SearchTeamsNotfound) {
                        return Center(child: Text(state.error));
                      } else {
                        List filteredTeams;
                        if (state is SearchTeamsFound) {
                          filteredTeams = state.teams;
                        } else {
                          filteredTeams = teams;
                        }

                        return GridView.builder(
                          itemCount: filteredTeams.length,
                          padding: const EdgeInsets.all(12),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 8,
                                childAspectRatio:
                                    Globals.fullSize(context).width / 110,
                              ),
                          itemBuilder: (context, index) {
                            final team = filteredTeams[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                            PlayersScreen(teamId: team.teamKey),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Globals.secondaryBackground,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        color: Globals.secondaryColor,
                                        fontSize: Globals.title,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Image.network(
                                      team.teamLogo ?? "",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (_, _, _) => Icon(
                                            Icons.broken_image,
                                            color: Globals.darkFont,
                                          ),
                                    ),
                                    const SizedBox(width: 24),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          team.teamName ?? "",
                                          style: TextStyle(
                                            color: Globals.secondaryColor,
                                            fontSize: Globals.title,
                                          ),
                                        ),
                                        Text(
                                          "Coach: ${team.coaches[0]?.coachName ?? ''}",
                                          style: TextStyle(
                                            color: Globals.darkFont,
                                            fontSize: Globals.subtitle,
                                          ),
                                        ),
                                        Text(
                                          "Players: ${team.players.length ?? '0'}",
                                          style: TextStyle(
                                            color: Globals.darkFont,
                                            fontSize: Globals.subtitle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("No Teams data available"));
          }
        },
      ),
    );
  }
}
