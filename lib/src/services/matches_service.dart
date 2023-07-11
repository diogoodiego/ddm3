import 'package:dio/dio.dart';

class MatchesService {
  final dio = Dio();
  final url = 'http://api.football-data.org/v4/competitions/BSA/matches';

  Future getMatches() async {
    final response = await dio.get(url,
        options: Options(
          headers: {
            'X-Auth-Token': 'f1568531fc6a4f359f5a2c522c63adb3',
          },
        ));
    final list = response.data['matches'] as List;

    return list;
  }
}
