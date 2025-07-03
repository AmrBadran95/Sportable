class CountriesResponse {
  final int? success;
  final List<Country?> result;

  CountriesResponse({required this.success, required this.result});

  factory CountriesResponse.fromJson(Map<String, dynamic> json) {
    return CountriesResponse(
      success: json["success"],
      result:
          (json["result"] as List)
              .map((item) => Country.fromJson(item))
              .toList(),
    );
  }
}

class Country {
  final int? countrykey;
  final String? countryname;
  final String? countryiso2;
  final String? countrylogo;

  Country({
    required this.countrykey,
    required this.countryname,
    required this.countryiso2,
    required this.countrylogo,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countrykey: json['country_key'],
      countryname: json['country_name'],
      countryiso2: json['country_iso2'],
      countrylogo: json['country_logo'],
    );
  }
}
