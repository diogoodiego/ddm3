import 'package:ddm3/src/models/team_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class TeamRepository extends ChangeNotifier {
  late Database db;

  List<TeamModel> _teams = [];
}
