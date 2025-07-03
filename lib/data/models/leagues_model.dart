class LeaguesResponse {
  final int success;
  final List<League?> result;

  LeaguesResponse({required this.success, required this.result});
  factory LeaguesResponse.fromJson(Map<String, dynamic> json) {
    return LeaguesResponse(
      success: json["success"],
      result:
          (json["result"] as List).map((el) => League.fromJson(el)).toList(),
    );
  }
}

class League {
  final int? leagueKey;
  final String? leagueName;
  final int? countryKey;
  final String? countryName;
  final String? leagueLogo;
  final String? countryLogo;

  League({
    required this.leagueKey,
    required this.leagueName,
    required this.countryKey,
    required this.countryName,
    required this.leagueLogo,
    required this.countryLogo,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      leagueKey: json["league_key"],
      leagueName: json["league_name"],
      countryKey: json["country_key"],
      countryName: json["country_name"],
      leagueLogo: json["league_logo"],
      countryLogo: json["country_logo"],
    );
  }
}
