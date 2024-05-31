import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String firebaseUrl =
    'ryc-desafio-do-modulo-basico-default-rtdb.firebaseio.com';

class PlayerStatsProvider with ChangeNotifier {
  int _health = 5;
  int _coins = 0;

  late String _playerStatsId;

  int get health => _health;

  int get coins => _coins;

  void addCoins(int amount) {
    _coins += amount;
    patchStats();
    notifyListeners();
  }

  void spendCoins(int amount) {
    final valueAfterSubtraction = _coins - amount;
    if (valueAfterSubtraction < 0) {
      return;
    }
    _coins -= amount;
    patchStats();
    notifyListeners();
  }

  void gainHealth() {
    if (_health == 5) {
      return;
    }
    _health++;
    patchStats();
    notifyListeners();
  }

  void loseHealth() {
    if (_health == 0) {
      return;
    }
    _health--;
    patchStats();
    notifyListeners();
  }

  void loadStats() async {
    final getResponse = await http.get(
      Uri.https(
        firebaseUrl,
        'player_stats.json',
      ),
    );

    final decodedGetBody = jsonDecode(getResponse.body);

    if (decodedGetBody == null) {
      final postResponse = await http.post(
        Uri.https(
          firebaseUrl,
          'player_stats.json',
        ),
        body: jsonEncode({
          'health': _health,
          'coins': _coins,
        }),
      );

      _playerStatsId = jsonDecode(postResponse.body)['name'];
    } else {
      final stats = decodedGetBody.values.toList().first;

      _playerStatsId = decodedGetBody.keys.toList().first;

      updateStats(stats['health'], stats['coins']);
    }
  }

  void updateStats(health, coins) {
    _health = health;
    _coins = coins;

    notifyListeners();
  }

  void patchStats() async {
    http.patch(
      Uri.https(firebaseUrl, 'player_stats/$_playerStatsId/.json'),
      body: jsonEncode({
        'health': _health,
        'coins': _coins,
      }),
    );
  }
}
