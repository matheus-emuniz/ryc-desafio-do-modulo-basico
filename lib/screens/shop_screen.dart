import 'package:flutter/material.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:provider/provider.dart';
import 'package:ryc_desafio_do_modulo_basico/components/dialogs.dart';
import 'package:ryc_desafio_do_modulo_basico/components/shop_item.dart';
import 'package:ryc_desafio_do_modulo_basico/providers/player_stats_provider.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playerStatsProvider = context.watch<PlayerStatsProvider>();
    return Container(
      child: ListView(
        children: [
          ShopItem(
            onBuyPressed: () {
              openConfirmBuyDialog(context, 'Poção de Vida').then((value) {
                if (value) {
                  playerStatsProvider.spendCoins(5);
                  playerStatsProvider.gainHealth();
                }
              });
            },
            title: 'Poção de Vida',
            description: const SizedBox(
              width: 50,
              child: Row(
                children: [
                  Text('Recupera 1'),
                  Icon(
                    Pixel.heart,
                    color: Colors.red,
                  )
                ],
              ),
            ),
            price: 5,
          )
        ],
      ),
    );
  }
}
