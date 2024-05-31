import 'package:flutter/material.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:ryc_desafio_do_modulo_basico/components/player_coins.dart';
import 'package:ryc_desafio_do_modulo_basico/components/player_health.dart';

class MainAppBar extends AppBar {
  MainAppBar({super.key})
      : super(
          title: const Text('Task Game'),
          centerTitle: true,
          actions: [
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: CircleAvatar(
                child: Image(
                  image: AssetImage('assets/images/user.png'),
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PlayerHealth(),
                    PlayerCoins(),
                  ],
                ),
              ),
            ),
          ),
          automaticallyImplyLeading: false,
        );
}
