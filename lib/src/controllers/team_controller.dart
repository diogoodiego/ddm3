import 'package:ddm3/src/services/team_matches_service.dart';
import 'package:flutter/material.dart';

class TeamController {
  List matches = [];
  final teamMatchesService = TeamMatchesService();
  final state = ValueNotifier<TeamState>(TeamState.start);

  Future start(team) async {
    state.value = TeamState.loading;
    try {
      matches = await teamMatchesService.getTeamMatches(team.id);
      state.value = TeamState.success;
    } catch (err) {
      state.value = TeamState.error;
    }
  }
}

enum TeamState { start, loading, success, error }
