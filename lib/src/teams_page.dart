import 'package:ddm3/src/team_page.dart';
import 'package:flutter/material.dart';
import 'package:ddm3/src/controllers/teams_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeamsPage extends StatefulWidget {
  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  final homeController = HomeController();

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
        itemCount: homeController.teams.length,
        itemBuilder: (context, index) {
          var team = homeController.teams[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TeamPage(team: team)));
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SvgPicture.network(
                    team.crest,
                    width: 48,
                    height: 48,
                    placeholderBuilder: (BuildContext context) => Image.network(
                      team.crest,
                      width: 48,
                      height: 48,
                    ),
                  ),
                  Text(team.name)
                ],
              ),
            ),
          );
        });
  }

  _error() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          homeController.start();
        },
        child: const Text('Tentar novamente'),
      ),
    );
  }

  stateManage(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.success:
        return _success();
      case HomeState.error:
        return _error();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clubes'),
        actions: [
          IconButton(
            onPressed: () {
              homeController.start();
            },
            icon: const Icon(Icons.refresh_rounded),
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: homeController.state,
        builder: (context, child) {
          return stateManage(homeController.state.value);
        },
      ),
    );
  }
}
