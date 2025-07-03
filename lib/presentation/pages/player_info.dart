import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sportable/Services/utils/globals.dart';
import 'package:sportable/data/models/player_model.dart';

class PlayerInfo extends StatelessWidget {
  final Player? player;

  const PlayerInfo({super.key, this.player});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: SizedBox(
                height: Globals.fullSize(context).height * .7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      player?.playerImage ?? "",
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.broken_image,
                          size: 150,
                          color: Globals.darkFont,
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          player?.playerName ?? "Unknown",
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.title,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Player's Number:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                        Text(
                          player?.playerNumber ?? "Unknown",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Player's Country:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                        Text(
                          player?.playerCountry ?? "Unknown",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Player's age:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                        Text(
                          player?.playerAge ?? "Unknown",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Player's Position:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                        Text(
                          player?.playerType ?? "Unknown",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Player's yellow cards:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                        Text(
                          player?.playerYellowCards ?? "0",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Player's red cards:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                        Text(
                          player?.playerRedCards ?? "0",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Player's assitst:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                        Text(
                          player?.playerAssists ?? "0",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Player's goals:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.subtitle,
                          ),
                        ),
                        Text(
                          player?.playerGoals ?? "0",
                          textAlign: TextAlign.right,
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
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.share,
                      color: Globals.secondaryColor,
                      size: Globals.title,
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Share",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Globals.secondaryColor,
                        fontSize: Globals.title,
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  final name = player?.playerName ?? "Unknown Player";
                  final team = player?.playerTeam ?? "Unknown Team";
                  final position = player?.playerType ?? "Unknown Position";
                  final goals = player?.playerGoals ?? "0";
                  final assists = player?.playerAssists ?? "0";

                  final shareText = '''
                                                       Check out this player!
                                                        Name: $name
                                                        Position: $position 
                                                        Goals: $goals 
                                                        Assists: $assists 
                                                        Team: $team
                                                        Shared via Sportable
                                                              ''';

                  await SharePlus.instance.share(
                    ShareParams(
                      text: shareText,
                      subject: 'Player Info from Sportable',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
