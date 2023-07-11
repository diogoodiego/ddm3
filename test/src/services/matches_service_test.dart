// ignore_for_file: avoid_print

import 'package:ddm3/src/services/matches_service.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final matchesService = MatchesService();
  test('Listagem de times', () async {
    final list = await matchesService.getMatches();
    print(list[1]['homeTeam']['name']);
  });
}
