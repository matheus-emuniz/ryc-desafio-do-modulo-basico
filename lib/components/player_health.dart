import 'package:flutter/material.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:provider/provider.dart';
import 'package:ryc_desafio_do_modulo_basico/providers/player_stats_provider.dart';

class HealthCounter extends StatelessWidget {
  final int threshold;
  final int currentPlayerHealth;

  const HealthCounter({
    super.key,
    required this.threshold,
    required this.currentPlayerHealth,
  });

  @override
  Widget build(BuildContext context) {
    bool isOverThreshold = currentPlayerHealth >= threshold;
    return Icon(
      isOverThreshold ? Pixel.heart : Pixel.close,
      size: isOverThreshold ? 40 : 30,
      color: isOverThreshold ? Colors.red : Colors.black,
    );
  }
}

class PlayerHealth extends StatelessWidget {
  const PlayerHealth({
    super.key,
  });

  List<Widget> _createHearts(int currentPlayerHealth) {
    List<Widget> result = [];
    for (int i = 0; i < 5; i++) {
      result.add(
        HealthCounter(
          threshold: i + 1,
          currentPlayerHealth: currentPlayerHealth,
        ),
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    int playerHealth = context.watch<PlayerStatsProvider>().health;
    return Row(
      children: _createHearts(playerHealth),
    );
  }
}
