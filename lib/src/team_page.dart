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

  checkFavorite() {}

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
          Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: SvgPicture.network(
                      team.crest,
                      width: 48,
                      height: 48,
                      placeholderBuilder: (BuildContext context) =>
                          Image.network(
                        team.crest,
                        width: 48,
                        height: 48,
                      ),
                    ),
                    title: Text(team.name),
                    subtitle: Text(
                      team.shortName,
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      if (teamController.isFavorited == true)
                        OutlinedButton.icon(
                            onPressed: () {
                              teamController.unfavorite(team);
                            },
                            icon: const Icon(Icons.favorite),
                            label: const Text("Favorito"))
                      else
                        ElevatedButton.icon(
                            onPressed: () {
                              teamController.favorite(team);
                            },
                            icon: const Icon(Icons.favorite_border_rounded),
                            label: const Text("Adicionar ao favoritos"))
                    ],
                  )
                ],
              )),
          const Text('Partidas'),
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: teamController.matches.length,
              itemBuilder: (context, index) {
                var match = teamController.matches[index];
                return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(children: [
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                              onPressed: () {},
                              icon: SvgPicture.network(
                                match['homeTeam']['crest'],
                                width: 48,
                                height: 48,
                                placeholderBuilder: (BuildContext context) =>
                                    Image.network(match['homeTeam']['crest'],
                                        width: 48, height: 48),
                              ),
                              label: Text(match['homeTeam']['name'])),
                          const Text('X'),
                          TextButton.icon(
                              onPressed: () {},
                              icon: SvgPicture.network(
                                match['awayTeam']['crest'],
                                width: 48,
                                height: 48,
                                placeholderBuilder: (BuildContext context) =>
                                    Image.network(match['awayTeam']['crest'],
                                        width: 48, height: 48),
                              ),
                              label: Text(match['awayTeam']['name'])),
                        ],
                      )
                    ]));
              }),
        ],
      ),
    );
  }

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
        IconButton(
            onPressed: () {
              teamController.start(team);
            },
            icon: const Icon(Icons.refresh_rounded))
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
