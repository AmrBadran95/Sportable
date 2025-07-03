import 'package:sportable/data/models/topscorers_model.dart';
import 'package:dio/dio.dart';

class TopscorersRepo {
  Dio dio = Dio();

  Future<TopscorersResponse?> getTopscorers(int leagueId) async {
    try {
      final Response response = await dio.get(
        "https://apiv2.allsportsapi.com/football/",
        queryParameters: {
          'met': 'Topscorers',
          'APIkey':
              '9142bddf2e392789b0a02af72d1df735e8986237cc552d938f2afbb5a1d6204e',
          'leagueId': leagueId,
        },
      );

      if (response.statusCode! > 299) {
        return null;
      } else {
        TopscorersResponse topscorersResponse = TopscorersResponse.fromJson(
          response.data,
        );
        return topscorersResponse;
      }
    } catch (e) {
      rethrow;
    }
  }
}
