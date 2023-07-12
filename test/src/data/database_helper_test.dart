// ignore_for_file: avoid_print

import 'package:ddm3/src/data/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('Adicionar favorito', () async {
    final favorite = await DatabaseHelper.getFavorites();
    print(favorite);
  });
  test('Busca favorito', () async {
    final favorite = await DatabaseHelper.getFavorites();
    print(favorite);
  });
}
