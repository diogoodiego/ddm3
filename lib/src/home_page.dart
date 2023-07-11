import 'package:ddm3/src/matches_page.dart';
import 'package:ddm3/src/teams_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('DDM3'), actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh_rounded))
        ]),
        body: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TeamsPage()));
              },
              title: const Text('Clubes'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MatchesPage()));
              },
              title: const Text('Partidas'),
            ),
          ],
        ));
  }
}
