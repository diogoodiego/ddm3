import 'package:ddm3/src/controllers/teams_controller.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final homeController = HomeController();

  test('Home Controller', () async {
    expect(homeController.state, HomeState.start);
    await homeController.start();
    expect(homeController.state, HomeState.success);
    print(homeController.teams.length);
  });
}
