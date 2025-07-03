import 'package:sportable/data/models/teams_model.dart';
import 'package:dio/dio.dart';

class TeamsRepo {
  Dio dio = Dio();

  Future<TeamsResponse?> getTeams(int leagueId) async {
    try {
      final Response response;
      response = await dio.get(
        'https://apiv2.allsportsapi.com/football/',
        queryParameters: {
          'met': 'Teams',
          'APIkey':
              '9142bddf2e392789b0a02af72d1df735e8986237cc552d938f2afbb5a1d6204e',
          'leagueId': leagueId,
        },
      );
      if (response.statusCode! > 299) {
        return null;
      } else {
        TeamsResponse teamsResponse = TeamsResponse.fromJson(response.data);

        return teamsResponse;
      }
    } catch (e) {
      rethrow;
    }
  }
}
