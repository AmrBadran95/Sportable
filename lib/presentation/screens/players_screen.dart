import 'package:sportable/Services/cubits/players_cubit/players_cubit.dart';
import 'package:sportable/Services/utils/globals.dart';
import 'package:sportable/data/repos/players_repo.dart';
import 'package:sportable/presentation/pages/player_info.dart';
import 'package:sportable/presentation/widgets/layout_with_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersScreen extends StatelessWidget {
  final int? teamId;
  const PlayersScreen({super.key, required this.teamId});

  @override
  Widget build(BuildContext context) {
    return LayoutWithDrawer(
      child: BlocProvider(
        create: (context) => PlayersCubit(PlayersRepo())..fetchPlayers(teamId!),
        child: BlocBuilder<PlayersCubit, PlayersState>(
          builder: (context, state) {
            if (state is PlayersLoading) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Globals.secondaryColor,
                  strokeWidth: 3,
                ),
              );
            } else if (state is PlayersError) {
              return Center(child: Text(state.error.toString()));
            } else if (state is PlayersSuccess) {
              return ListView.builder(
                itemCount: state.playersResponse.result.length - 1,
                itemBuilder: (context, index) {
                  final player = state.playersResponse.result[index + 1];
                  return InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => PlayerInfo(player: player),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.all(8),
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
                          SizedBox(width: 12),
                          Image.network(
                            player?.playerImage ?? "",
                            width: 60,
                            height: 60,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.broken_image,
                                size: 60,
                                color: Globals.darkFont,
                              );
                            },
                          ),
                          SizedBox(width: 24),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                player?.playerName ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Globals.secondaryColor,
                                  fontSize: Globals.title,
                                ),
                              ),
                              Text(
                                player?.playerNumber ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Globals.darkFont,
                                  fontSize: Globals.subtitle,
                                ),
                              ),
                              Text(
                                player?.playerType ?? "",
                                overflow: TextOverflow.ellipsis,
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
            } else {
              return Center(child: Text("Failed to get Players data"));
            }
          },
        ),
      ),
    );
  }
}
