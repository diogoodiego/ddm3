import 'package:ddm3/src/team_page.dart';
import 'package:flutter/material.dart';
import 'package:ddm3/src/controllers/teams_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeamsPage extends StatefulWidget {
  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  final teamsController = TeamsController();

  _start() {
    return Container();
  }

  _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  _success() {
    return ListView.builder(
        itemCount: teamsController.teams.length,
        itemBuilder: (context, index) {
          var team = teamsController.teams[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TeamPage(team: team)));
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: SvgPicture.network(
                  team.crest,
                  width: 48,
                  height: 48,
                  placeholderBuilder: (BuildContext context) => Image.network(
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
            ),
          );
        });
  }

  _error() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          teamsController.start();
        },
        child: const Text('Tentar novamente'),
      ),
    );
  }

  stateManage(TeamsState state) {
    switch (state) {
      case TeamsState.start:
        return _start();
      case TeamsState.loading:
        return _loading();
      case TeamsState.success:
        return _success();
      case TeamsState.error:
        return _error();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    teamsController.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clubes'),
        actions: [
          IconButton(
            onPressed: () {
              teamsController.start();
            },
            icon: const Icon(Icons.refresh_rounded),
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: teamsController.state,
        builder: (context, child) {
          return stateManage(teamsController.state.value);
        },
      ),
    );
  }
}
