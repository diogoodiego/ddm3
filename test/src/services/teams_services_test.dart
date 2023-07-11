import 'package:ddm3/src/services/teams_service.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final teamsService = TeamsSerice();
  test('Listagem de times', () async {
    final list = await teamsService.getTeams();
    print(list[0].name);
  });
}
