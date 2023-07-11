import 'package:ddm3/src/services/matches_service.dart';
import 'package:flutter/material.dart';

class MatchesController {
  List matches = [];
  final matchesService = MatchesService();
  final state = ValueNotifier<MatchesState>(MatchesState.start);

  Future start() async {
    state.value = MatchesState.loading;
    try {
      matches = await matchesService.getMatches();
      state.value = MatchesState.success;
    } catch (err) {
      state.value = MatchesState.error;
    }
  }
}

enum MatchesState { start, loading, success, error }
