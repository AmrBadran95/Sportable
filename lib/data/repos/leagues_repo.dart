import 'package:sportable/data/models/leagues_model.dart';
import 'package:dio/dio.dart';

class LeaguesRepo {
  Dio dio = Dio();

  Future<LeaguesResponse?> getLeagues(int countryId) async {
    try {
      final Response response;
      response = await dio.get(
        'https://apiv2.allsportsapi.com/football/',
        queryParameters: {
          'met': 'Leagues',
          'APIkey':
              '9142bddf2e392789b0a02af72d1df735e8986237cc552d938f2afbb5a1d6204e',
          'countryId': countryId,
        },
      );
      if (response.statusCode! > 299) {
        return null;
      } else {
        LeaguesResponse leaguesResponse = LeaguesResponse.fromJson(
          response.data,
        );
        return leaguesResponse;
      }
    } catch (e) {
      rethrow;
    }
  }
}
