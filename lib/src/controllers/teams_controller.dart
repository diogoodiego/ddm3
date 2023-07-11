import 'package:ddm3/src/models/team_model.dart';
import 'package:ddm3/src/services/teams_service.dart';
import 'package:flutter/material.dart';

class HomeController {
  List<TeamModel> teams = [];
  final teamsService = TeamsSerice();
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future start() async {
    state.value = HomeState.loading;
    try {
      teams = await teamsService.getTeams();
      state.value = HomeState.success;
    } catch (err) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error }
