import 'package:ddm3/src/models/team_model.dart';
import 'package:ddm3/src/services/teams_service.dart';
import 'package:flutter/material.dart';

class TeamsController {
  List<TeamModel> teams = [];
  final teamsService = TeamsSerice();
  final state = ValueNotifier<TeamsState>(TeamsState.start);

  Future start() async {
    state.value = TeamsState.loading;
    try {
      teams = await teamsService.getTeams();
      state.value = TeamsState.success;
    } catch (err) {
      state.value = TeamsState.error;
    }
  }
}

enum TeamsState { start, loading, success, error }
