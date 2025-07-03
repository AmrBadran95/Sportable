class Coach {
  final String? coachName;
  final String? coachCountry;
  final String? coachAge;

  Coach({
    required this.coachName,
    required this.coachCountry,
    required this.coachAge,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      coachName: json["coach_name"],
      coachCountry: json["coach_country"],
      coachAge: json["coach_age"],
    );
  }
}
