import 'package:ddm3/src/models/team_model.dart';
import 'package:ddm3/src/controllers/team_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class TeamPage extends StatefulWidget {
  TeamModel team;
  TeamPage({super.key, required this.team});

  @override
  State<TeamPage> createState() {
    return _TeamPageState(team: team);
  }
}

class _TeamPageState extends State<TeamPage> {
  TeamModel team;
  _TeamPageState({required this.team});

  final teamController = TeamController();

  _start() {
    return Container();
  }

  _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  _success() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.network(
                team.crest,
                width: 64,
                height: 64,
                placeholderBuilder: (BuildContext context) => Image.network(
                  team.crest,
                  width: 64,
                  height: 64,
                ),
              ),
              Text(team.name)
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: teamController.matches.length,
              itemBuilder: (context, index) {
                var match = teamController.matches[index];
                return ListTile(
                  title: Text(match['homeTeam']['name'] +
                      ' x ' +
                      match['awayTeam']['name']),
                );
              }),
        ],
      ),
    );
  }
  // _success() {
  //   return Container(
  //     child: Column(children: [
  //       Row(
  //         children: [
  //           SvgPicture.network(
  //             team.crest,
  //             width: 64,
  //             height: 64,
  //             placeholderBuilder: (BuildContext context) => Image.network(
  //               team.crest,
  //               width: 64,
  //               height: 64,
  //             ),
  //           ),
  //           Text(team.name)
  //         ],
  //       ),
  //       Row(
  //         children: [
  //           ElevatedButton(onPressed: () {}, child: const Text('Visitar site')),
  //           ElevatedButton(onPressed: () {}, child: const Text('Elenco'))
  //         ],
  //       ),
  //       ListView.builder(
  //           itemCount: teamController.matches.length,
  //           itemBuilder: (context, index) {
  //             var match = teamController.matches[index];
  //             return ListTile(
  //               title: Text(match['homeTeam']['name'] +
  //                   ' x ' +
  //                   match['awayTeam']['name']),
  //             );
  //           }),
  //     ]),
  //   );
  // }

  _error() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          teamController.start(team);
        },
        child: const Text('Tentar novamente'),
      ),
    );
  }

  stateManage(TeamState state) {
    switch (state) {
      case TeamState.start:
        return _start();
      case TeamState.loading:
        return _loading();
      case TeamState.success:
        return _success();
      case TeamState.error:
        return _error();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    super.initState();
    teamController.start(team);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(team.name), actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.refresh_rounded))
      ]),
      body: AnimatedBuilder(
        animation: teamController.state,
        builder: (context, child) {
          return stateManage(teamController.state.value);
        },
      ),
    );
  }
}
