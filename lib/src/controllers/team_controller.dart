import 'package:ddm3/src/data/database_helper.dart';
import 'package:ddm3/src/models/team_model.dart';
import 'package:ddm3/src/services/team_matches_service.dart';
import 'package:flutter/material.dart';

class TeamController {
  List matches = [];
  bool isFavorited = false;
  final teamMatchesService = TeamMatchesService();
  final state = ValueNotifier<TeamState>(TeamState.start);

  Future start(team) async {
    state.value = TeamState.loading;

    final favoriteTeam = await DatabaseHelper.getFavorite(team.id);
    if (favoriteTeam.isNotEmpty) {
      isFavorited = true;
    } else {
      isFavorited = false;
    }

    try {
      matches = await teamMatchesService.getTeamMatches(team.id);
      state.value = TeamState.success;
    } catch (err) {
      state.value = TeamState.error;
    }
  }

  Future favorite(team) async {
    state.value = TeamState.loading;
    try {
      DatabaseHelper.createFavorite(team.id, team.name, team.shortName,
          team.tla, team.crest, team.address, team.website);
      isFavorited = true;
      state.value = TeamState.success;
    } catch (err) {
      state.value = TeamState.error;
    }
  }

  Future unfavorite(team) async {
    state.value = TeamState.loading;
    try {
      DatabaseHelper.deleteFavorite(team.id);
      isFavorited = false;
      state.value = TeamState.success;
    } catch (err) {
      state.value = TeamState.error;
    }
  }
}

enum TeamState { start, loading, success, error }
