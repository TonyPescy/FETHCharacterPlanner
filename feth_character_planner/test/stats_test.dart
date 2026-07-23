import 'package:flutter_test/flutter_test.dart';
import 'package:feth_character_planner/models/stats.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('loads Hilda base stats from the bundled JSON data', () async {
    final stats = Stats();

    final baseStats = await stats.getCharacterBaseStats('Hilda');

    expect(baseStats['HP'], 29.0);
    expect(baseStats['Str'], 10.0);
  });
}
