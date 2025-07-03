class PlayersResponse {
  final int? success;
  final List<Player?> result;

  PlayersResponse({required this.success, required this.result});

  factory PlayersResponse.fromJson(Map<String, dynamic> json) {
    return PlayersResponse(
      success: json["success"],
      result:
          (json["result"] as List).map((el) => Player.fromJson(el)).toList(),
    );
  }
}

class Player {
  final int? playerKey;
  final String? playerName;
  final String? playerNumber;
  final String? playerImage;
  final String? playerCountry;
  final String? playerType;
  final String? playerAge;
  final String? playerYellowCards;
  final String? playerRedCards;
  final String? playerGoals;
  final String? playerAssists;
  final String? playerTeam;

  Player({
    required this.playerKey,
    required this.playerName,
    required this.playerNumber,
    required this.playerImage,
    required this.playerCountry,
    required this.playerType,
    required this.playerAge,
    required this.playerYellowCards,
    required this.playerRedCards,
    required this.playerGoals,
    required this.playerAssists,
    required this.playerTeam,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      playerKey: json["player_key"],
      playerName: json["player_name"],
      playerNumber: json["player_number"],
      playerImage: json["player_image"],
      playerCountry: json["player_country"],
      playerType: json["player_type"],
      playerAge: json["player_age"],
      playerYellowCards: json["player_yellow_cards"],
      playerRedCards: json["player_red_cards"],
      playerGoals: json["player_goals"],
      playerAssists: json["player_assists"],
      playerTeam: json["team_name"],
    );
  }
}
