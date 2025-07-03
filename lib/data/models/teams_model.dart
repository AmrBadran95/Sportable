
import 'package:sportable/data/models/coach_model.dart';
import 'package:sportable/data/models/player_model.dart';

class TeamsResponse {
  final int? success;
  final List<Team?> result;
  TeamsResponse({required this.success, required this.result});
  factory TeamsResponse.fromJson(Map<String, dynamic> json) {
    return TeamsResponse(
      success: json["success"],
      result: (json["result"] as List).map((el) => Team.fromJson(el)).toList(),
    );
  }
}

class Team {
  final int? teamKey;
  final String? teamName;
  final String? teamLogo;
  final List<Player?> players;
  final List<Coach?> coaches;

  Team({
    required this.teamKey,
    required this.teamName,
    required this.teamLogo,
    required this.players,
    required this.coaches,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamKey: json["team_key"],
      teamName: json["team_name"],
      teamLogo: json["team_logo"],
      players:
          (json["players"] as List).map((el) => Player.fromJson(el)).toList(),
      coaches:
          (json["coaches"] as List).map((el) => Coach.fromJson(el)).toList(),
    );
  }
}
