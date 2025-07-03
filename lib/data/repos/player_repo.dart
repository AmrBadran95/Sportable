import 'package:sportable/data/models/player_model.dart';
import 'package:dio/dio.dart';

class PlayersRepo {
  final dio = Dio();

  Future<PlayersResponse?> getPlayers(int playerId) async {
    try {
      final Response response = await dio.get(
        'https://apiv2.allsportsapi.com/football/',
        queryParameters: {
          'met': 'Players',
          'APIkey':
              '9142bddf2e392789b0a02af72d1df735e8986237cc552d938f2afbb5a1d6204e',
          "playerId": playerId,
        },
      );
      if (response.statusCode! > 299) {
        return null;
      } else {
        PlayersResponse playersResponse = PlayersResponse.fromJson(
          response.data,
        );
        return playersResponse;
      }
    } catch (e) {
      rethrow;
    }
  }
}
