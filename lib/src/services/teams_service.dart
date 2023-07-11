import 'package:ddm3/src/models/team_model.dart';
import 'package:dio/dio.dart';

class TeamsSerice {
  final dio = Dio();
  final url = 'http://api.football-data.org/v4/competitions/BSA/teams';

  Future<List<TeamModel>> getTeams() async {
    final response = await dio.get(url,
        options: Options(
          headers: {
            'X-Auth-Token': 'f1568531fc6a4f359f5a2c522c63adb3',
          },
        ));
    final list = response.data['teams'] as List;

    List<TeamModel> teams = [];
    for (var item in list) {
      final team = TeamModel.fromJson(item);
      teams.add(team);
    }

    return teams;
  }
}
