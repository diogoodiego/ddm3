import 'package:ddm3/src/data/database_helper.dart';
import 'package:flutter/material.dart';

class HomeController {
  List favorites = [];
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future start() async {
    state.value = HomeState.loading;
    try {
      favorites = await DatabaseHelper.getFavorites();
      state.value = HomeState.success;
    } catch (err) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error }
