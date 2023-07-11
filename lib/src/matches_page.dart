import 'package:ddm3/src/controllers/matches_controller.dart';
import 'package:flutter/material.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  final matchesController = MatchesController();

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
        itemCount: matchesController.matches.length,
        itemBuilder: (context, index) {
          var match = matchesController.matches[index];
          return ListTile(
            title: Text(
                match['homeTeam']['name'] + ' x ' + match['awayTeam']['name']),
          );
        });
  }

  _error() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          matchesController.start();
        },
        child: const Text('Tentar novamente'),
      ),
    );
  }

  stateManage(MatchesState state) {
    switch (state) {
      case MatchesState.start:
        return _start();
      case MatchesState.loading:
        return _loading();
      case MatchesState.success:
        return _success();
      case MatchesState.error:
        return _error();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    super.initState();
    matchesController.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Partidas'), actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.refresh_rounded))
      ]),
      body: AnimatedBuilder(
        animation: matchesController.state,
        builder: (context, child) {
          return stateManage(matchesController.state.value);
        },
      ),
    );
  }
}
