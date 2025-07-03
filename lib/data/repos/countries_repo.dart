import 'package:sportable/data/models/countries_model.dart';
import 'package:dio/dio.dart';

class CountriesRepo {
  Dio dio = Dio();

  Future<CountriesResponse?> getCountries() async {
    try {
      final Response response;
      response = await dio.get(
        'https://apiv2.allsportsapi.com/football/',
        queryParameters: {
          'met': 'Countries',
          'APIkey':
              '9142bddf2e392789b0a02af72d1df735e8986237cc552d938f2afbb5a1d6204e',
        },
      );
      if (response.statusCode! > 299) {
        return null;
      } else {
        CountriesResponse countriesResponse = CountriesResponse.fromJson(
          response.data,
        );
        return countriesResponse;
      }
    } catch (e) {
      rethrow;
    }
  }
}
