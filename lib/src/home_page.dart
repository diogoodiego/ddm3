import 'package:ddm3/src/controllers/home_controller.dart';
import 'package:ddm3/src/matches_page.dart';
import 'package:ddm3/src/models/team_model.dart';
import 'package:ddm3/src/team_page.dart';
import 'package:ddm3/src/teams_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return SingleChildScrollView(
      child: Column(children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(children: [
            ListTile(
              leading: SvgPicture.network(
                'https://logodownload.org/wp-content/uploads/2018/10/campeonato-brasileiro-logo-brasileirao-logo-1.png',
                width: 64,
                height: 64,
                placeholderBuilder: (BuildContext context) => Image.network(
                  'https://logodownload.org/wp-content/uploads/2018/10/campeonato-brasileiro-logo-brasileirao-logo-1.png',
                  width: 64,
                  height: 64,
                ),
              ),
              title: const Text('Campeonato Brasileiro Série A'),
              subtitle: Text(
                '2023',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MatchesPage()));
                    },
                    child: const Text('Partidas')),
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => TeamsPage()));
                    },
                    child: const Text('Clubes'))
              ],
            )
          ]),
        ),
        const Text("Meus favoritos"),
        ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: homeController.favorites.length,
            itemBuilder: (context, index) {
              var favorite =
                  TeamModel.fromJson(homeController.favorites[index]);
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TeamPage(team: favorite)));
                },
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    leading: SvgPicture.network(
                      favorite.crest,
                      width: 48,
                      height: 48,
                      placeholderBuilder: (BuildContext context) =>
                          Image.network(
                        favorite.crest,
                        width: 48,
                        height: 48,
                      ),
                    ),
                    title: Text(favorite.name),
                    subtitle: Text(
                      favorite.shortName,
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ),
              );
            })
      ]),
    );
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
    super.initState();
    homeController.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DDM3'), actions: [
        IconButton(
            onPressed: () {
              homeController.start();
            },
            icon: const Icon(Icons.refresh_rounded))
      ]),
      body: AnimatedBuilder(
        animation: homeController.state,
        builder: (context, child) {
          return stateManage(homeController.state.value);
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('DDM3'), actions: [
  //       IconButton(onPressed: () {}, icon: const Icon(Icons.refresh_rounded))
  //     ]),
  //     body: Column(
  //       children: [
  //         ListView(
  //           shrinkWrap: true,
  //           children: [
  //             ListTile(
  //               onTap: () {
  //                 Navigator.of(context).push(
  //                     MaterialPageRoute(builder: (context) => TeamsPage()));
  //               },
  //               title: const Text('Clubes'),
  //             ),
  //             ListTile(
  //               onTap: () {
  //                 Navigator.of(context).push(MaterialPageRoute(
  //                     builder: (context) => const MatchesPage()));
  //               },
  //               title: const Text('Partidas'),
  //             ),
  //             Text('Meus favoritos'),
  //             AnimatedBuilder(
  //               animation: homeController.state,
  //               builder: (context, child) {
  //                 return stateManage(homeController.state.value);
  //               },
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
