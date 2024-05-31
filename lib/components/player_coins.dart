import 'package:flutter/material.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:provider/provider.dart';
import 'package:ryc_desafio_do_modulo_basico/providers/player_stats_provider.dart';

class PlayerCoins extends StatelessWidget {
  const PlayerCoins({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Pixel.coin,
          color: Colors.orangeAccent,
          size: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            context.watch<PlayerStatsProvider>().coins.toString(),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
