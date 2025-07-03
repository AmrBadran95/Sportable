class TopscorersResponse {
  final int success;
  final List<Topscorers?> result;

  TopscorersResponse({required this.success, required this.result});

  factory TopscorersResponse.fromJson(Map<String, dynamic> json) {
    return TopscorersResponse(
      success: json["success"],
      result:
          (json["result"] as List)
              .map((el) => Topscorers.fromJson(el))
              .toList(),
    );
  }
}

class Topscorers {
  final int? playerPlace;
  final String? playerName;
  final int? playerKey;
  final String? teamName;
  final int? teamKey;
  final int? goals;
  final int? assists;
  final int? penaltyGoals;

  Topscorers({
    required this.playerPlace,
    required this.playerName,
    required this.playerKey,
    required this.teamName,
    required this.teamKey,
    required this.goals,
    required this.assists,
    required this.penaltyGoals,
  });

  factory Topscorers.fromJson(Map<String, dynamic> json) {
    return Topscorers(
      playerPlace: json["player_place"],
      playerName: json["player_name"],
      playerKey: json["player_key"],
      teamName: json["team_name"],
      teamKey: json["team_key"],
      goals: json["goals"],
      assists: json["assists"],
      penaltyGoals: json["penalty_goals"],
    );
  }
}
